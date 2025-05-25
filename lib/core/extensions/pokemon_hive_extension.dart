import 'package:rama_poke_app/core/databases/hive_model/pokemon_hive_model.dart';
import 'package:rama_poke_app/core/databases/mappers/string_to_pokemon_type_mapper.dart';
import 'package:rama_poke_app/core/shared/models/pokemon_model.dart';

extension PokemonHiveExtension on PokemonHiveModel {
  PokemonEntityModel toEntity(
    List<PokemonHiveModel> evolutions,
    bool isFavorite,
  ) => PokemonEntityModel(
    id: id,
    abilities: abilities,
    attack: attack,
    baseExp: baseExp,
    category: category,
    cycles: cycles,
    eggGroups: eggGroups,
    evolvedfrom: evolvedfrom,
    femalePercentage: femalePercentage,
    genderless: genderless,
    height: height,
    imageurl: imageurl,
    malePercentage: malePercentage,
    name: name,
    reason: reason,
    specialAttack: specialAttack,
    specialDefense: specialDefense,
    speed: speed,
    total: total,
    weaknesses:
        (weaknesses ?? [])
            .map((x) => StringToPokemonTypeMapper().map(x))
            .toList(),
    typeofpokemon:
        (typeofpokemon ?? [])
            .map((x) => StringToPokemonTypeMapper().map(x))
            .toList(),
    defense: defense,
    evolutions: evolutions.map((e) => e.toEntity([], false)).toList(),
    hp: hp,
    xdescription: xdescription,
    ydescription: ydescription,
    weight: weight,
    isFavorite: isFavorite,
  );
}
