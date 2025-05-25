import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rama_poke_app/core/config/di/di.dart';
import 'package:rama_poke_app/core/constants/api_constant.dart';
import 'package:rama_poke_app/core/databases/mappers/pokemon_data_mapper.dart';
import 'package:rama_poke_app/core/databases/services/favorite_local_service.dart';
import 'package:rama_poke_app/core/databases/services/pokemon_local_service.dart';
import 'package:rama_poke_app/core/extensions/pokemon_hive_extension.dart';
import 'package:rama_poke_app/core/services/network_service.dart';
import 'package:rama_poke_app/core/shared/models/pokemon_model.dart';
import 'package:rama_poke_app/modules/pokedex/models/pokemon_response_model.dart';

@injectable
class PokedexRepository {
  final pokemonDb = getIt<PokemonLocalService>();
  final favoriteDb = getIt<FavoriteLocalService>();
  final mapper = getIt<PokemonDataMapper>();

  Future<Either<String, PokemonEntityModel>> getPokemon(String id) async {
    if (await pokemonDb.hasLocalPokemonData()) {
      final pokemon = await pokemonDb.getPokemon(id);
      if (pokemon == null) {
        return Left('Pokemon not found');
      }

      final evolutions = await pokemonDb.getEvolutions(pokemon);
      final isFavorite = await favoriteDb.isFavorite(pokemon.id ?? "");

      return Right(pokemon.toEntity(evolutions, isFavorite));
    } else {
      return _fetchAndCachePokemons().then((result) {
        return result.fold((error) => Left(error), (_) async {
          final pokemon = await pokemonDb.getPokemon(id);
          if (pokemon == null) {
            return Left('Pokemon not found');
          }

          final evolutions = await pokemonDb.getEvolutions(pokemon);
          final isFavorite = await favoriteDb.isFavorite(pokemon.id ?? "");

          return Right(pokemon.toEntity(evolutions, isFavorite));
        });
      });
    }
  }

  // Updated getPokemons method with filtering
  Future<Either<String, List<PokemonEntityModel>>> getPokemons({
    required int page,
    required int limit,
    String? nameFilter,
    List<String>? typeFilters,
  }) async {
    if (await pokemonDb.hasLocalPokemonData()) {
      return _getLocalPokemons(
        page: page,
        limit: limit,
        nameFilter: nameFilter,
        typeFilters: typeFilters,
      );
    }

    return _fetchAndCachePokemons().then((result) {
      return result.fold(
        (error) => Left(error),
        (_) => _getLocalPokemons(
          page: page,
          limit: limit,
          nameFilter: nameFilter,
          typeFilters: typeFilters,
        ),
      );
    });
  }

  Future<Either<String, List<PokemonEntityModel>>> _getLocalPokemons({
    required int page,
    required int limit,
    String? nameFilter,
    List<String>? typeFilters,
  }) async {
    try {
      final pokemons = await pokemonDb.getFilteredPokemons(
        page: page,
        limit: limit,
        nameFilter: nameFilter,
        typeFilters: typeFilters,
      );

      final pokemonIds = pokemons.map((x) => x.id ?? "").toList();
      final favoriteStatusMap = await favoriteDb.getFavoriteStatusMap(
        pokemonIds,
      );

      final pokemonEntities =
          pokemons.map((pokemon) {
            final isFavorite = favoriteStatusMap[pokemon.id ?? ""] ?? false;
            return pokemon.toEntity([], isFavorite);
          }).toList();

      return Right(pokemonEntities);
    } catch (e) {
      return Left('Failed to load local pokemon data: ${e.toString()}');
    }
  }

  Future<Either<String, Unit>> _fetchAndCachePokemons() async {
    final result = await NetworkService.request(
      (dio) async => await dio.get(ApiConstant.pokemonList),
    );

    return result.fold((error) => Left(error), (response) async {
      try {
        final decoded =
            response.data is String
                ? json.decode(response.data)
                : response.data;

        final pokemons =
            (decoded as List<dynamic>)
                .map((json) => PokemonResponseModel.fromJson(json))
                .toList();

        final data = await mapper.networkToLocal(pokemons);
        await pokemonDb.savePokemons(data);

        return const Right(unit);
      } catch (e) {
        return Left('Failed to parse and cache pokemon data: ${e.toString()}');
      }
    });
  }
}
