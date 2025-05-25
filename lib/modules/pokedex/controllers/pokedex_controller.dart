import 'package:flutter/material.dart';
import 'package:rama_poke_app/core/config/di/di.dart';
import 'package:rama_poke_app/core/shared/models/pokemon_model.dart';
import 'package:rama_poke_app/core/state/ui_state.dart';
import 'package:rama_poke_app/modules/pokedex/repositories/pokedex_repository.dart';
import 'package:rama_poke_app/modules/pokedex/repositories/selected_type_repository.dart';

class PokedexController extends ChangeNotifier {
  // Dependencies
  final PokedexRepository _pokedexRepository = getIt<PokedexRepository>();
  final SelectedTypeRepository _selectedTypeRepository =
      getIt<SelectedTypeRepository>();

  // Pokemon list state
  UIState<List<PokemonEntityModel>> _pokemonsState =
      UIState<List<PokemonEntityModel>>.idle();
  UIState<List<PokemonEntityModel>> get pokemonsState => _pokemonsState;

  TypeOfPokemon? _selectedType;
  TypeOfPokemon? get selectedType => _selectedType;

  // Pagination
  bool _hasMore = true;
  bool get hasMore => _hasMore;

  int _currentPage = 1;
  int get currentPage => _currentPage;

  static const int _limit = 10;

  // Filters
  String? _nameFilter;
  String? get nameFilter => _nameFilter;

  final TextEditingController searchController = TextEditingController();

  bool get hasActiveFilters => _nameFilter != null;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  /// Fetches Pokemon with optional pagination
  Future<void> fetchPokemons({bool loadMore = false}) async {
    if (_pokemonsState.isLoading() || (loadMore && !_hasMore)) return;

    try {
      _updatePaginationState(loadMore);
      _updatePokemonLoadingState(loadMore);

      if (!loadMore) {
        /// Intentionally to show the loading :)
        await Future.delayed(const Duration(milliseconds: 500));
      }

      final result = await _pokedexRepository.getPokemons(
        page: _currentPage,
        limit: _limit,
        nameFilter: _nameFilter,
        typeFilters: _selectedType != null ? [_selectedType?.name ?? ""] : null,
      );

      await result.fold(
        (error) => _handlePokemonError(error, loadMore),
        (pokemons) => _handlePokemonSuccess(pokemons, loadMore),
      );
    } catch (e) {
      await _handlePokemonError(e.toString(), loadMore);
    } finally {
      notifyListeners();
    }
  }

  /// Updates pagination state based on load type
  void _updatePaginationState(bool loadMore) {
    if (loadMore) {
      _currentPage++;
    } else {
      _currentPage = 1;
      _hasMore = true;
    }
  }

  /// Updates loading state for Pokemon list
  void _updatePokemonLoadingState(bool loadMore) {
    _pokemonsState =
        loadMore
            ? UIState.loadingMore(_pokemonsState.dataSuccess() ?? [])
            : UIState<List<PokemonEntityModel>>.loading();
    notifyListeners();
  }

  /// Handles Pokemon fetch errors
  Future<void> _handlePokemonError(String error, bool loadMore) async {
    if (loadMore) _currentPage--;

    _pokemonsState = UIState.error(
      message: error,
      data: loadMore ? _pokemonsState.dataSuccess() : null,
    );
  }

  Future<void> _handlePokemonSuccess(
    List<PokemonEntityModel> pokemons,
    bool loadMore,
  ) async {
    final List<PokemonEntityModel> newData =
        loadMore
            ? [...(_pokemonsState.dataSuccess() ?? []), ...pokemons]
            : pokemons;

    _hasMore = pokemons.length == _limit;
    _pokemonsState = UIState<List<PokemonEntityModel>>.success(data: newData);
  }

  /// Fetch saved Type Of Pokemon
  Future<void> fetchTypeOfPokemon() async {
    try {
      var result = await _selectedTypeRepository.getSelectedTypeOfPokemon();

      result.fold(
        (error) {
          _selectedType = null;
        },
        (data) {
          _selectedType = data;
        },
      );
    } catch (e) {
      _selectedType = null;
    } finally {
      notifyListeners();
    }
  }

  /// Sets name filter and refreshes data
  void setNameFilter(String? name) {
    final trimmedName = name?.trim();
    _nameFilter = trimmedName?.isEmpty == true ? null : trimmedName;
    _resetAndFetch();
  }

  void setSelectedType(TypeOfPokemon? type) {
    _selectedType = type;
    _resetAndFetch();
  }

  /// Clears all filters and refreshes data
  void clearFilters() {
    _nameFilter = null;
    searchController.clear();
    _selectedType = null;
    _resetAndFetch();
  }

  /// Resets pagination and fetches fresh data
  void _resetAndFetch() {
    _currentPage = 1;
    _hasMore = true;
    fetchPokemons(loadMore: false);
  }

  /// Refreshes the Pokemon list
  Future<void> refresh() async {
    await fetchTypeOfPokemon();
    await fetchPokemons(loadMore: false);
  }
}
