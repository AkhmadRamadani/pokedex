import 'package:flutter/material.dart';
import 'package:rama_poke_app/core/config/di/di.dart';
import 'package:rama_poke_app/core/shared/models/pokemon_model.dart';
import 'package:rama_poke_app/core/state/ui_state.dart';
import 'package:rama_poke_app/modules/favorite/controllers/favorite_controller.dart';
import 'package:rama_poke_app/modules/pokedex/repositories/pokedex_repository.dart';

class DetailController extends ChangeNotifier {
  UIState<PokemonEntityModel> pokemonState = UIState<PokemonEntityModel>.idle();
  final PokedexRepository _repository = getIt<PokedexRepository>();
  final FavoriteController favoriteController = getIt<FavoriteController>();

  Future<void> getPokemon(String id) async {
    try {
      pokemonState = UIState.loading();
      notifyListeners();
      final result = await _repository.getPokemon(id);
      result.fold(
        (error) {
          pokemonState = UIState.error(message: error);
          notifyListeners();
        },
        (pokemon) {
          pokemonState = UIState<PokemonEntityModel>.success(data: pokemon);
          notifyListeners();
        },
      );
    } catch (e) {
      pokemonState = UIState.error(message: e.toString());
      notifyListeners();
    }
  }

  Future<void> toggleFavorite(BuildContext context, PokemonEntityModel pokemon) async {
    final pokemonId = pokemon.id ?? "";
    if (pokemonId.isEmpty) return;

    final originalFavoriteState = pokemon.isFavorite ?? false;
    final newState = !originalFavoriteState;

    _updatePokemonFavoriteStatus(pokemonId, newState);
    notifyListeners();

    final result = await favoriteController.toggleFavorite(
      context,
      pokemonId,
      originalFavoriteState,
    );

    if (result != newState) {
      _updatePokemonFavoriteStatus(pokemonId, result);
    }
    await favoriteController.refreshFavorites();
    notifyListeners();
  }

  void _updatePokemonFavoriteStatus(String pokemonId, bool isFavorite) {
    final pokemon = pokemonState.dataSuccess();
    if (pokemon != null) {
      final updatedPokemon = pokemon.copyWith(isFavorite: isFavorite);
      pokemonState = UIState.success(data: updatedPokemon);
      notifyListeners();
    }
  }
}
