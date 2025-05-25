import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rama_poke_app/core/config/di/di.dart';
import 'package:rama_poke_app/core/databases/local_database.dart';
import 'package:rama_poke_app/core/databases/mappers/pokemon_data_mapper.dart';
import 'package:rama_poke_app/core/shared/models/pokemon_model.dart';

@injectable
class FavoriteRepository {
  final db = getIt<LocalDatabase>();
  final mapper = getIt<PokemonDataMapper>();

  /// Toggle favorite status and return the new state
  Future<bool> toggleFavorite(String pokemonId) async {
    try {
      final newFavoriteState = await db.toggleFavorite(pokemonId);
      return newFavoriteState;
    } catch (e) {
      // Log the error for debugging
      debugPrint('Error toggling favorite for Pokemon $pokemonId: $e');
      rethrow; // Re-throw to let the caller handle it
    }
  }

  /// Get current favorite status
  Future<bool> isFavorite(String pokemonId) async {
    try {
      return await db.isFavorite(pokemonId);
    } catch (e) {
      debugPrint('Error checking favorite status for Pokemon $pokemonId: $e');
      return false; // Default to false if there's an error
    }
  }

  /// Get all favorite Pokemon IDs
  Future<List<String>> getFavoriteIds() async {
    try {
      return await db.getFavoriteIds();
    } catch (e) {
      debugPrint('Error getting favorite IDs: $e');
      return [];
    }
  }

  Future<Either<String, List<PokemonEntityModel>>> getFavorites() async {
    try {
      final result = await db.getFavoritePokemons();
      final entities = await mapper.localToEntity(result);

      return Right(entities);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
