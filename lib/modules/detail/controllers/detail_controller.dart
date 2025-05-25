import 'package:flutter/material.dart';
import 'package:rama_poke_app/core/config/di/di.dart';
import 'package:rama_poke_app/core/shared/models/pokemon_model.dart';
import 'package:rama_poke_app/core/state/ui_state.dart';
import 'package:rama_poke_app/modules/pokedex/repositories/pokedex_repository.dart';

class DetailController extends ChangeNotifier {
  UIState<PokemonEntityModel> pokemonState = UIState<PokemonEntityModel>.idle();
  final PokedexRepository _repository = getIt<PokedexRepository>();

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
}
