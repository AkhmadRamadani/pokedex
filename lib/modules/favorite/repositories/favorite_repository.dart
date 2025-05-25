import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rama_poke_app/core/config/di/di.dart';
import 'package:rama_poke_app/core/databases/mappers/pokemon_data_mapper.dart';
import 'package:rama_poke_app/core/databases/services/favorite_local_service.dart';
import 'package:rama_poke_app/core/databases/services/pokemon_local_service.dart';
import 'package:rama_poke_app/core/shared/models/pokemon_model.dart';

@injectable
class FavoriteRepository {
  final favoriteDb = getIt<FavoriteLocalService>();
  final pokemonDb = getIt<PokemonLocalService>();
  final mapper = getIt<PokemonDataMapper>();

  Future<bool> toggleFavorite(String pokemonId) async {
    try {
      final newFavoriteState = await favoriteDb.toggleFavorite(pokemonId);
      return newFavoriteState;
    } catch (e) {
      debugPrint('Error toggling favorite for Pokemon $pokemonId: $e');
      rethrow;
    }
  }

  Future<List<String>> getFavoriteIds() async {
    try {
      return await favoriteDb.getFavoriteIds();
    } catch (e) {
      debugPrint('Error getting favorite IDs: $e');
      return [];
    }
  }

  Future<Either<String, List<PokemonEntityModel>>> getFavorites() async {
    try {
      final result = await favoriteDb.getFavoritesSortedByDate();
      final entities = await mapper.localToEntity(result);

      return Right(entities);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
