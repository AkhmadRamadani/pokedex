import 'dart:math' hide log;

import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:rama_poke_app/core/databases/constants/hive_constant.dart';
import 'package:rama_poke_app/core/databases/hive_model/pokemon_hive_model.dart';

@lazySingleton
class LocalDatabase {
  Future<void> initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(PokemonHiveModelAdapter());

    await Hive.openBox<PokemonHiveModel>(HiveConstant.pokemonBoxKey);
    await Hive.openBox<String>(HiveConstant.selectedTypeKey);
  }

  // ==================== Pokémon Methods ====================

  Future<bool> hasLocalPokemonData() async {
    final pokemonBox = Hive.box<PokemonHiveModel>(HiveConstant.pokemonBoxKey);
    return pokemonBox.isNotEmpty;
  }

  Future<List<PokemonHiveModel>> getAllPokemons() async {
    final pokemonBox = Hive.box<PokemonHiveModel>(HiveConstant.pokemonBoxKey);
    return List.generate(
      pokemonBox.length,
      (index) => pokemonBox.getAt(index),
    ).whereType<PokemonHiveModel>().toList();
  }

  // Original getPokemons method (keep for backward compatibility)
  Future<List<PokemonHiveModel>> getPokemons({
    required int page,
    required int limit,
  }) async {
    return getFilteredPokemons(page: page, limit: limit);
  }

  // New filtered method
  Future<List<PokemonHiveModel>> getFilteredPokemons({
    required int page,
    required int limit,
    String? nameFilter,
    List<String>? typeFilters,
  }) async {
    final pokemonBox = Hive.box<PokemonHiveModel>(HiveConstant.pokemonBoxKey);

    // Get all pokemons and apply filters
    List<PokemonHiveModel> allPokemons = [];
    for (int i = 0; i < pokemonBox.length; i++) {
      final pokemon = pokemonBox.getAt(i);
      if (pokemon != null) {
        allPokemons.add(pokemon);
      }
    }

    // Apply filters
    List<PokemonHiveModel> filteredPokemons = _applyFilters(
      allPokemons,
      nameFilter: nameFilter,
      typeFilters: typeFilters,
    );

    // Apply pagination
    final start = (page - 1) * limit;
    if (start >= filteredPokemons.length) return [];

    final end = min(start + limit, filteredPokemons.length);
    return filteredPokemons.sublist(start, end);
  }

  // Helper method to apply filters
  List<PokemonHiveModel> _applyFilters(
    List<PokemonHiveModel> pokemons, {
    String? nameFilter,
    List<String>? typeFilters,
  }) {
    List<PokemonHiveModel> filtered = pokemons;

    // Apply name filter
    if (nameFilter != null && nameFilter.isNotEmpty) {
      filtered =
          filtered.where((pokemon) {
            final name = pokemon.name?.toLowerCase() ?? '';
            return name.contains(nameFilter.toLowerCase());
          }).toList();
    }

    // Apply type filters
    if (typeFilters != null && typeFilters.isNotEmpty) {
      filtered =
          filtered.where((pokemon) {
            final pokemonTypes =
                pokemon.typeofpokemon?.map((t) => t.toLowerCase()).toList() ??
                [];
            final filterTypes =
                typeFilters.map((t) => t.toLowerCase()).toList();

            return filterTypes.any(
              (filterType) => pokemonTypes.contains(filterType),
            );
          }).toList();
    }

    return filtered;
  }

  Future<PokemonHiveModel?> getPokemon(String id) async {
    final pokemonBox = Hive.box<PokemonHiveModel>(HiveConstant.pokemonBoxKey);
    return pokemonBox.get(id);
  }

  Future<List<PokemonHiveModel>> getEvolutions(PokemonHiveModel pokemon) async {
    final futures = (pokemon.evolutions ?? []).map(getPokemon);
    final results = await Future.wait(futures);
    return results.whereType<PokemonHiveModel>().toList();
  }

  Future<void> savePokemons(List<PokemonHiveModel> pokemons) async {
    final box = Hive.box<PokemonHiveModel>(HiveConstant.pokemonBoxKey);
    for (final pokemon in pokemons) {
      if (pokemon.id != null) {
        await box.put(pokemon.id, pokemon);
      }
    }
  }

  static const _selectedTypesKey = 'selected_types';

  Future<void> saveSelectedType(String types) async {
    final box = Hive.box(HiveConstant.selectedTypeKey);
    await box.put(_selectedTypesKey, types);
  }

  Future<String> getSelectedType() async {
    final box = Hive.box(HiveConstant.selectedTypeKey);
    final type = box.get(_selectedTypesKey);
    return type;
  }

  Future<void> clearSelectedTypes() async {
    final box = Hive.box(HiveConstant.selectedTypeKey);
    await box.delete(_selectedTypesKey);
  }
}
