import 'package:hive_ce/hive.dart';

part 'pokemon_hive_model.g.dart';

@HiveType(typeId: 0)
class PokemonHiveModel extends HiveObject {
  @HiveField(0)
  String? name;

  @HiveField(1)
  String? id;

  @HiveField(2)
  String? imageurl;

  @HiveField(3)
  String? xdescription;

  @HiveField(4)
  String? ydescription;

  @HiveField(5)
  String? height;

  @HiveField(6)
  String? category;

  @HiveField(7)
  String? weight;

  @HiveField(8)
  List<String>? typeofpokemon;

  @HiveField(9)
  List<String>? weaknesses;

  @HiveField(10)
  List<String>? evolutions;

  @HiveField(11)
  List<String>? abilities;

  @HiveField(12)
  int? hp;

  @HiveField(13)
  int? attack;

  @HiveField(14)
  int? defense;

  @HiveField(15)
  int? specialAttack;

  @HiveField(16)
  int? specialDefense;

  @HiveField(17)
  int? speed;

  @HiveField(18)
  int? total;

  @HiveField(19)
  double? malePercentage;

  @HiveField(20)
  double? femalePercentage;

  @HiveField(21)
  int? genderless;

  @HiveField(22)
  String? cycles;

  @HiveField(23)
  String? eggGroups;

  @HiveField(24)
  String? evolvedfrom;

  @HiveField(25)
  String? reason;

  @HiveField(26)
  String? baseExp;

  PokemonHiveModel({
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
  });
}
