import 'package:flutter/material.dart';
import 'package:rama_poke_app/core/assets/element/element_color.dart';
import 'package:rama_poke_app/core/extensions/type_of_pokemon_extension.dart';

class PokemonEntityModel {
  String? name;
  String? id;
  String? imageurl;
  String? xdescription;
  String? ydescription;
  String? height;
  String? category;
  String? weight;
  List<TypeOfPokemon>? typeofpokemon;
  List<TypeOfPokemon>? weaknesses;
  List<PokemonEntityModel>? evolutions;
  List<String>? abilities;
  int? hp;
  int? attack;
  int? defense;
  int? specialAttack;
  int? specialDefense;
  int? speed;
  int? total;
  double? malePercentage;
  double? femalePercentage;
  int? genderless;
  String? cycles;
  String? eggGroups;
  String? evolvedfrom;
  String? reason;
  String? baseExp;
  bool? isFavorite;

  PokemonEntityModel({
    this.name,
    this.id,
    this.imageurl,
    this.xdescription,
    this.ydescription,
    this.height,
    this.category,
    this.weight,
    this.typeofpokemon,
    this.weaknesses,
    this.evolutions,
    this.abilities,
    this.hp,
    this.attack,
    this.defense,
    this.specialAttack,
    this.specialDefense,
    this.speed,
    this.total,
    this.malePercentage,
    this.femalePercentage,
    this.genderless,
    this.cycles,
    this.eggGroups,
    this.evolvedfrom,
    this.reason,
    this.baseExp,
    this.isFavorite,
  });

  PokemonEntityModel copyWith({
    String? name,
    String? id,
    String? imageurl,
    String? xdescription,
    String? ydescription,
    String? height,
    String? category,
    String? weight,
    List<TypeOfPokemon>? typeofpokemon,
    List<TypeOfPokemon>? weaknesses,
    List<PokemonEntityModel>? evolutions,
    List<String>? abilities,
    int? hp,
    int? attack,
    int? defense,
    int? specialAttack,
    int? specialDefense,
    int? speed,
    int? total,
    double? malePercentage,
    double? femalePercentage,
    int? genderless,
    String? cycles,
    String? eggGroups,
    String? evolvedfrom,
    String? reason,
    String? baseExp,
    bool? isFavorite,
  }) => PokemonEntityModel(
    name: name ?? this.name,
    id: id ?? this.id,
    imageurl: imageurl ?? this.imageurl,
    xdescription: xdescription ?? this.xdescription,
    ydescription: ydescription ?? this.ydescription,
    height: height ?? this.height,
    category: category ?? this.category,
    weight: weight ?? this.weight,
    typeofpokemon: typeofpokemon ?? this.typeofpokemon,
    weaknesses: weaknesses ?? this.weaknesses,
    evolutions: evolutions ?? this.evolutions,
    abilities: abilities ?? this.abilities,
    hp: hp ?? this.hp,
    attack: attack ?? this.attack,
    defense: defense ?? this.defense,
    specialAttack: specialAttack ?? this.specialAttack,
    specialDefense: specialDefense ?? this.specialDefense,
    speed: speed ?? this.speed,
    total: total ?? this.total,
    malePercentage: malePercentage ?? this.malePercentage,
    femalePercentage: femalePercentage ?? this.femalePercentage,
    genderless: genderless ?? this.genderless,
    cycles: cycles ?? this.cycles,
    eggGroups: eggGroups ?? this.eggGroups,
    evolvedfrom: evolvedfrom ?? this.evolvedfrom,
    reason: reason ?? this.reason,
    baseExp: baseExp ?? this.baseExp,
    isFavorite: isFavorite ?? this.isFavorite,
  );

  Color get color => typeofpokemon?.first.color ?? ElementColor.allTypeElement;
}

enum TypeOfPokemon {
  bug,
  dark,
  dragon,
  electric,
  fairy,
  fighting,
  fire,
  flying,
  ghost,
  grass,
  ground,
  ice,
  normal,
  poison,
  psychic,
  rock,
  steel,
  water,
}
