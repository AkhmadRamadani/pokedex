import 'package:flutter/material.dart';
import 'package:rama_poke_app/core/config/di/di.dart';
import 'package:rama_poke_app/core/shared/models/pokemon_model.dart';
import 'package:rama_poke_app/core/state/ui_state.dart';
import 'package:rama_poke_app/modules/favorite/controllers/favorite_controller.dart';
import 'package:rama_poke_app/modules/pokedex/controllers/selected_type_controller.dart';
import 'package:rama_poke_app/modules/pokedex/repositories/pokedex_repository.dart';

class PokedexController extends ChangeNotifier {
  final PokedexRepository _pokedexRepository = getIt<PokedexRepository>();
  final FavoriteController favoriteController = getIt<FavoriteController>();
  final SelectedTypeController selectedTypeController =
      getIt<SelectedTypeController>();

  UIState<List<PokemonEntityModel>> _pokemonsState = UIState.idle();
  UIState<List<PokemonEntityModel>> get pokemonsState => _pokemonsState;

  bool _hasMore = true;
  bool get hasMore => _hasMore;

  int _currentPage = 1;
  int get currentPage => _currentPage;
  static const int _limit = 10;

  String? _nameFilter;
  String? get nameFilter => _nameFilter;
  final TextEditingController searchController = TextEditingController();

  bool get hasActiveFilters => _nameFilter != null;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> fetchPokemons({bool loadMore = false}) async {
    if (_pokemonsState.isLoading() || (loadMore && !_hasMore)) return;

    try {
      _updatePaginationState(loadMore);
      _updatePokemonLoadingState(loadMore);

      if (!loadMore) {
        await Future.delayed(const Duration(milliseconds: 500));
      }

      final selectedType = selectedTypeController.selectedType;

      final result = await _pokedexRepository.getPokemons(
        page: _currentPage,
        limit: _limit,
        nameFilter: _nameFilter,
        typeFilters: selectedType != null ? [selectedType.name] : null,
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

  void _updatePaginationState(bool loadMore) {
    if (loadMore) {
      _currentPage++;
    } else {
      _currentPage = 1;
      _hasMore = true;
    }
  }

  void _updatePokemonLoadingState(bool loadMore) {
    _pokemonsState =
        loadMore
            ? UIState.loadingMore(_pokemonsState.dataSuccess() ?? [])
            : UIState.loading();
    notifyListeners();
  }

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
    final favoriteIds = await favoriteController.getFavoriteIds();
    final updatedPokemons =
        pokemons.map((pokemon) {
          final isFavorite = favoriteIds.contains(pokemon.id);
          return pokemon.copyWith(isFavorite: isFavorite);
        }).toList();

    List<PokemonEntityModel> newData =
        loadMore
            ? [...(_pokemonsState.dataSuccess() ?? []), ...updatedPokemons]
            : updatedPokemons;

    _hasMore = pokemons.length == _limit;
    _pokemonsState = UIState<List<PokemonEntityModel>>.success(data: newData);
  }

  void setNameFilter(String? name) {
    final trimmedName = name?.trim();
    _nameFilter = trimmedName?.isEmpty == true ? null : trimmedName;
    _resetAndFetch();
  }

  void setSelectedType(TypeOfPokemon? type) async {
    await selectedTypeController.setSelectedType(type);
    _resetAndFetch();
  }

  void clearFilters() {
    _nameFilter = null;
    searchController.clear();
    selectedTypeController.setSelectedType(null);
    _resetAndFetch();
  }

  void _resetAndFetch() {
    _currentPage = 1;
    _hasMore = true;
    fetchPokemons(loadMore: false);
  }

  Future<void> refresh() async {
    await selectedTypeController.fetchSelectedType();
    await fetchPokemons(loadMore: false);
  }

  Future<void> toggleFavorite(
    BuildContext context,
    PokemonEntityModel pokemon,
  ) async {
    final pokemonId = pokemon.id ?? "";
    if (pokemonId.isEmpty) return;

    final originalFavoriteState = pokemon.isFavorite ?? false;
    final newState = !originalFavoriteState;

    updatePokemonFavoriteStatus(pokemonId, newState);
    notifyListeners();

    final result = await favoriteController.toggleFavorite(
      context,
      pokemonId,
      originalFavoriteState,
    );

    if (result != newState) {
      updatePokemonFavoriteStatus(pokemonId, result);
    }
    await favoriteController.refreshFavorites();
    notifyListeners();
  }

  void updatePokemonFavoriteStatus(String pokemonId, bool isFavorite) {
    final pokemonList = _pokemonsState.dataSuccess();
    if (pokemonList != null) {
      final updatedList =
          pokemonList.map((pokemon) {
            if (pokemon.id == pokemonId) {
              return pokemon.copyWith(isFavorite: isFavorite);
            }
            return pokemon;
          }).toList();

      _pokemonsState = UIState<List<PokemonEntityModel>>.success(
        data: updatedList,
      );

      notifyListeners();
    }
  }
}
