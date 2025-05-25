import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rama_poke_app/core/config/di/di.dart';
import 'package:rama_poke_app/core/shared/models/pokemon_model.dart';
import 'package:rama_poke_app/core/state/ui_state.dart';
import 'package:rama_poke_app/modules/favorite/repositories/favorite_repository.dart';

@singleton
class FavoriteController extends ChangeNotifier {
  final FavoriteRepository _favoriteRepository = getIt<FavoriteRepository>();
  final Set<String> _togglingFavorites = {};

  UIState<List<PokemonEntityModel>> _favoriteState = UIState.idle();
  UIState<List<PokemonEntityModel>> get favoriteState => _favoriteState;

  bool isToggling(String id) => _togglingFavorites.contains(id);

  Future<void> getFavorites() async {
    try {
      _favoriteState = UIState.loading();
      notifyListeners();
      final result = await _favoriteRepository.getFavorites();
      result.fold(
        (error) => _favoriteState = UIState.error(message: error),
        (pokemons) => _favoriteState = UIState.success(data: pokemons),
      );
    } catch (e) {
      _favoriteState = UIState.error(message: e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<bool> toggleFavorite(
    BuildContext context,
    String pokemonId,
    bool isCurrentlyFavorite,
  ) async {
    try {
      _togglingFavorites.add(pokemonId);
      notifyListeners();

      final result = await _favoriteRepository.toggleFavorite(pokemonId);

      if (_favoriteState.isSuccess()) {
        final currentData = _favoriteState.dataSuccess()!;
        final updated =
            isCurrentlyFavorite
                ? currentData.where((p) => p.id != pokemonId).toList()
                : [...currentData];

        _favoriteState = UIState.success(data: updated);
      }

      var currentPokemon = await _favoriteRepository.pokemonDb.getPokemon(
        pokemonId,
      );

      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title:
              result
                  ? '${currentPokemon?.name ?? ""} joined your favorites!'
                  : '${currentPokemon?.name ?? ""} removed from favorites!',
          message:
              result
                  ? 'Nice catch! ${currentPokemon?.name ?? ""} is now part of your squad.'
                  : 'Oops! ${currentPokemon?.name ?? ""} is no longer in your collection.',
          contentType: result ? ContentType.success : ContentType.warning,
        ),
      );

      if (!context.mounted) return result;
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      return result;
    } catch (e) {
      debugPrint('Error toggling favorite: $e');
      return isCurrentlyFavorite;
    } finally {
      _togglingFavorites.remove(pokemonId);
      notifyListeners();
    }
  }

  Future<Set<String>> getFavoriteIds() async {
    try {
      final ids = await _favoriteRepository.getFavoriteIds();
      return ids.toSet();
    } catch (e) {
      debugPrint('Error getting favorite IDs: $e');
      return {};
    }
  }

  Future<void> refreshFavorites() async {
    await getFavorites();
  }
}
