import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rama_poke_app/core/config/di/di.dart';
import 'package:rama_poke_app/core/constants/api_constant.dart';
import 'package:rama_poke_app/core/databases/local_database.dart';
import 'package:rama_poke_app/core/databases/mappers/pokemon_data_mapper.dart';
import 'package:rama_poke_app/core/extensions/pokemon_hive_extension.dart';
import 'package:rama_poke_app/core/services/network_service.dart';
import 'package:rama_poke_app/core/shared/models/pokemon_model.dart';
import 'package:rama_poke_app/modules/pokedex/models/pokemon_response_model.dart';

@injectable
class PokedexRepository {
  final db = getIt<LocalDatabase>();
  final mapper = getIt<PokemonDataMapper>();

  Future<Either<String, PokemonEntityModel>> getPokemon(String id) async {
    if (await db.hasLocalPokemonData()) {
      final pokemon = await db.getPokemon(id);
      if (pokemon == null) {
        return Left('Pokemon not found');
      }

      final evolutions = await db.getEvolutions(pokemon);
      return Right(pokemon.toEntity(evolutions));
    } else {
      return _fetchAndCachePokemons().then((result) {
        return result.fold((error) => Left(error), (_) async {
          final pokemon = await db.getPokemon(id);
          if (pokemon == null) {
            return Left('Pokemon not found');
          }

          final evolutions = await db.getEvolutions(pokemon);
          return Right(pokemon.toEntity(evolutions));
        });
      });
    }
  }

  Future<Either<String, List<PokemonEntityModel>>> getAllPokemons() async {
    if (await db.hasLocalPokemonData()) {
      final data = await db.getAllPokemons();
      return Right(data.map((x) => x.toEntity([])).toList());
    } else {
      return _fetchAndCachePokemons().then((result) {
        return result.fold((error) => Left(error), (_) async {
          final data = await db.getAllPokemons();
          return Right(data.map((x) => x.toEntity([])).toList());
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
    print(typeFilters);
    if (await db.hasLocalPokemonData()) {
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

  // Updated _getLocalPokemons with filtering logic
  Future<Either<String, List<PokemonEntityModel>>> _getLocalPokemons({
    required int page,
    required int limit,
    String? nameFilter,
    List<String>? typeFilters,
  }) async {
    try {
      final pokemons = await db.getFilteredPokemons(
        page: page,
        limit: limit,
        nameFilter: nameFilter,
        typeFilters: typeFilters,
      );
      return Right(pokemons.map((x) => x.toEntity([])).toList());
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
        await db.savePokemons(data);

        return const Right(unit);
      } catch (e) {
        return Left('Failed to parse and cache pokemon data: ${e.toString()}');
      }
    });
  }
}
