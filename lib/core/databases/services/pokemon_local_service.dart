import 'dart:math';

import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:rama_poke_app/core/databases/constants/hive_constant.dart';
import 'package:rama_poke_app/core/databases/hive_model/pokemon_hive_model.dart';

class PokemonLocalService {
  Box<PokemonHiveModel> get _pokemonBox =>
      Hive.box<PokemonHiveModel>(HiveConstant.pokemonBoxKey);

  Future<bool> hasLocalPokemonData() async => _pokemonBox.isNotEmpty;

  Future<List<PokemonHiveModel>> getPokemons({
    required int page,
    required int limit,
  }) {
    return getFilteredPokemons(page: page, limit: limit);
  }

  Future<List<PokemonHiveModel>> getFilteredPokemons({
    required int page,
    required int limit,
    String? nameFilter,
    List<String>? typeFilters,
  }) async {
    final allPokemons = _pokemonBox.values.toList();
    final filtered = _applyFilters(allPokemons, nameFilter, typeFilters);
    final start = (page - 1) * limit;
    if (start >= filtered.length) return [];
    final end = min(start + limit, filtered.length);
    return filtered.sublist(start, end);
  }

  List<PokemonHiveModel> _applyFilters(
    List<PokemonHiveModel> pokemons,
    String? nameFilter,
    List<String>? typeFilters,
  ) {
    return pokemons.where((pokemon) {
      final matchesName =
          nameFilter == null ||
          (pokemon.name?.toLowerCase() ?? '').contains(
            nameFilter.toLowerCase(),
          );
      final matchesType =
          typeFilters == null ||
          typeFilters.isEmpty ||
          (pokemon.typeofpokemon?.any(
                (t) => typeFilters.contains(t.toLowerCase()),
              ) ??
              false);
      return matchesName && matchesType;
    }).toList();
  }

  Future<PokemonHiveModel?> getPokemon(String id) async => _pokemonBox.get(id);

  Future<List<PokemonHiveModel>> getEvolutions(PokemonHiveModel pokemon) async {
    final futures = (pokemon.evolutions ?? []).map(getPokemon);
    final results = await Future.wait(futures);
    return results.whereType<PokemonHiveModel>().toList();
  }

  Future<void> savePokemons(List<PokemonHiveModel> pokemons) async {
    for (final p in pokemons) {
      if (p.id != null) await _pokemonBox.put(p.id, p);
    }
  }
}
