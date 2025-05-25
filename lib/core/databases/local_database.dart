import 'dart:math' hide log;

import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:rama_poke_app/core/databases/constants/hive_constant.dart';
import 'package:rama_poke_app/core/databases/hive_model/favorite_hive_model.dart';
import 'package:rama_poke_app/core/databases/hive_model/pokemon_hive_model.dart';

@singleton
class LocalDatabase {
  Future<void> initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(PokemonHiveModelAdapter());
    Hive.registerAdapter(FavoriteHiveModelAdapter());

    await Hive.openBox<PokemonHiveModel>(HiveConstant.pokemonBoxKey);
    await Hive.openBox<FavoriteHiveModel>(HiveConstant.favoriteBoxKey);
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
    final box = Hive.box<String>(HiveConstant.selectedTypeKey);
    await box.put(_selectedTypesKey, types);
  }

  Future<String?> getSelectedType() async {
    final box = Hive.box<String>(HiveConstant.selectedTypeKey);
    final type = box.get(_selectedTypesKey);
    return type;
  }

  Future<void> clearSelectedTypes() async {
    final box = Hive.box<String>(HiveConstant.selectedTypeKey);
    await box.clear();
  }

  // ==================== Favorites Methods ====================

  /// Add a pokemon to favorites
  Future<void> addToFavorites(String pokemonId) async {
    final favoriteBox = Hive.box<FavoriteHiveModel>(
      HiveConstant.favoriteBoxKey,
    );

    // Check if already exists
    if (await isFavorite(pokemonId)) {
      return; // Already in favorites
    }

    final favorite = FavoriteHiveModel(
      entityId: pokemonId,
      addedAt: DateTime.now(),
      order: favoriteBox.length, // Auto-increment order
    );

    await favoriteBox.put(pokemonId, favorite);
  }

  /// Remove a pokemon from favorites
  Future<void> removeFromFavorites(String pokemonId) async {
    final favoriteBox = Hive.box<FavoriteHiveModel>(
      HiveConstant.favoriteBoxKey,
    );
    await favoriteBox.delete(pokemonId);
  }

  /// Toggle favorite status of a pokemon
  Future<bool> toggleFavorite(String pokemonId) async {
    if (await isFavorite(pokemonId)) {
      await removeFromFavorites(pokemonId);
      return false;
    } else {
      await addToFavorites(pokemonId);
      return true;
    }
  }

  /// Check if a pokemon is in favorites
  Future<bool> isFavorite(String pokemonId) async {
    final favoriteBox = Hive.box<FavoriteHiveModel>(
      HiveConstant.favoriteBoxKey,
    );
    return favoriteBox.containsKey(pokemonId);
  }

  /// Get all favorite pokemon IDs
  Future<List<String>> getFavoriteIds() async {
    final favoriteBox = Hive.box<FavoriteHiveModel>(
      HiveConstant.favoriteBoxKey,
    );
    return favoriteBox.values.map((favorite) => favorite.entityId).toList();
  }

  /// Get all favorite pokemons (full data)
  Future<List<PokemonHiveModel>> getFavoritePokemons() async {
    final favoriteIds = await getFavoriteIds();
    final pokemonBox = Hive.box<PokemonHiveModel>(HiveConstant.pokemonBoxKey);

    List<PokemonHiveModel> favoritePokemons = [];
    for (String id in favoriteIds) {
      final pokemon = pokemonBox.get(id);
      if (pokemon != null) {
        favoritePokemons.add(pokemon);
      }
    }

    return favoritePokemons;
  }

  /// Get favorite pokemons with pagination
  Future<List<PokemonHiveModel>> getFavoritePokemonsPaginate({
    required int page,
    required int limit,
  }) async {
    final allFavorites = await getFavoritePokemons();

    final start = (page - 1) * limit;
    if (start >= allFavorites.length) return [];

    final end = min(start + limit, allFavorites.length);
    return allFavorites.sublist(start, end);
  }

  /// Get favorite pokemons ordered by date added (newest first)
  Future<List<PokemonHiveModel>> getFavoritesSortedByDate({
    bool ascending = false,
  }) async {
    final favoriteBox = Hive.box<FavoriteHiveModel>(
      HiveConstant.favoriteBoxKey,
    );
    final pokemonBox = Hive.box<PokemonHiveModel>(HiveConstant.pokemonBoxKey);

    // Get favorites sorted by date
    List<FavoriteHiveModel> sortedFavorites = favoriteBox.values.toList();
    sortedFavorites.sort(
      (a, b) =>
          ascending
              ? a.addedAt.compareTo(b.addedAt)
              : b.addedAt.compareTo(a.addedAt),
    );

    // Get corresponding pokemon data
    List<PokemonHiveModel> result = [];
    for (final favorite in sortedFavorites) {
      final pokemon = pokemonBox.get(favorite.entityId);
      if (pokemon != null) {
        result.add(pokemon);
      }
    }

    return result;
  }

  /// Get count of favorite pokemons
  Future<int> getFavoritesCount() async {
    final favoriteBox = Hive.box<FavoriteHiveModel>(
      HiveConstant.favoriteBoxKey,
    );
    return favoriteBox.length;
  }

  /// Clear all favorites
  Future<void> clearAllFavorites() async {
    final favoriteBox = Hive.box<FavoriteHiveModel>(
      HiveConstant.favoriteBoxKey,
    );
    await favoriteBox.clear();
  }

  /// Get favorite status for multiple pokemons (for bulk checking)
  Future<Map<String, bool>> getFavoriteStatusMap(
    List<String> pokemonIds,
  ) async {
    final favoriteBox = Hive.box<FavoriteHiveModel>(
      HiveConstant.favoriteBoxKey,
    );

    Map<String, bool> statusMap = {};
    for (String id in pokemonIds) {
      statusMap[id] = favoriteBox.containsKey(id);
    }

    return statusMap;
  }

  /// Get a specific favorite record
  Future<FavoriteHiveModel?> getFavoriteRecord(String pokemonId) async {
    final favoriteBox = Hive.box<FavoriteHiveModel>(
      HiveConstant.favoriteBoxKey,
    );
    return favoriteBox.get(pokemonId);
  }
}
