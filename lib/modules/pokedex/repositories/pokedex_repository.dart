import 'package:dartz/dartz.dart';
import 'package:rama_poke_app/core/constants/api_constant.dart';
import 'package:rama_poke_app/core/services/network_service.dart';
import 'package:rama_poke_app/modules/pokedex/models/pokemon_response_model.dart';

class PokedexRepository {
  Future<Either<String, List<PokemonResponseModel>>> getPokemons() async {
    final result = await NetworkService.request(
      (dio) async => await dio.get(ApiConstant.pokemonList),
    );

    return result.fold((error) => Left(error), (response) {
      try {
        final List<dynamic> data = response.data;
        final pokemons =
            data.map((json) => PokemonResponseModel.fromJson(json)).toList();

        return Right(pokemons);
      } catch (e) {
        return Left('Failed to parse pokemon data: ${e.toString()}');
      }
    });
  }
}
