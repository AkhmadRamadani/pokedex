import 'package:injectable/injectable.dart';
import 'package:rama_poke_app/core/config/di/di.dart';
import 'package:rama_poke_app/core/databases/hive_model/pokemon_hive_model.dart';
import 'package:rama_poke_app/core/databases/local_database.dart';
import 'package:rama_poke_app/core/extensions/pokemon_hive_extension.dart';
import 'package:rama_poke_app/core/shared/models/pokemon_model.dart';
import 'package:rama_poke_app/modules/pokedex/models/pokemon_response_model.dart';

@injectable
class PokemonDataMapper {
  final db = getIt<LocalDatabase>();
  Future<List<PokemonHiveModel>> networkToLocal(
    List<PokemonResponseModel> data,
  ) async {
    double parsePercentage(String percentageString) {
      return double.parse(percentageString.replaceAll('%', ''));
    }

    final List<PokemonHiveModel> pokemons =
        data
            .map(
              (pokemon) => PokemonHiveModel(
                id: pokemon.id,
                name: pokemon.name,
                abilities:
                    (pokemon.abilities ?? [])
                        .map((ability) => ability)
                        .toList(),
                attack: pokemon.attack,
                defense: pokemon.defense,
                hp: pokemon.hp,
                baseExp: pokemon.baseExp,
                category: pokemon.category,
                cycles: pokemon.cycles,
                eggGroups: pokemon.eggGroups,
                evolvedfrom: pokemon.evolvedfrom,
                femalePercentage: parsePercentage(
                  pokemon.femalePercentage ?? "0%",
                ),
                malePercentage: parsePercentage(pokemon.malePercentage ?? "0%"),
                genderless: pokemon.genderless,
                height: pokemon.height,
                imageurl: pokemon.imageurl,
                reason: pokemon.reason,
                specialAttack: pokemon.specialAttack,
                specialDefense: pokemon.specialDefense,
                speed: pokemon.speed,
                total: pokemon.total,
                weight: pokemon.weight,
                xdescription: pokemon.xdescription,
                ydescription: pokemon.ydescription,
                typeofpokemon: (pokemon.typeofpokemon ?? []),
                weaknesses: (pokemon.weaknesses ?? []),
                evolutions: (pokemon.evolutions ?? []),
              ),
            )
            .toList();

    return pokemons;
  }

  Future<List<PokemonEntityModel>> localToEntity(
    List<PokemonHiveModel> data,
  ) async {
    final entities = await Future.wait(
      data.map((pokemon) async {
        final evolutions = await db.getEvolutions(pokemon);
        return pokemon.toEntity(evolutions);
      }),
    );
    return entities;
  }
}
