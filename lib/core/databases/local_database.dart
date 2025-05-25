import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:rama_poke_app/core/databases/abstract_hive_service.dart';
import 'package:rama_poke_app/core/databases/constants/hive_constant.dart';
import 'package:rama_poke_app/core/databases/hive_model/favorite_hive_model.dart';
import 'package:rama_poke_app/core/databases/hive_model/pokemon_hive_model.dart';

class LocalDatabase implements HiveService {
  @override
  Future<void> initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(PokemonHiveModelAdapter());
    Hive.registerAdapter(FavoriteHiveModelAdapter());

    await Hive.openBox<PokemonHiveModel>(HiveConstant.pokemonBoxKey);
    await Hive.openBox<FavoriteHiveModel>(HiveConstant.favoriteBoxKey);
    await Hive.openBox<String>(HiveConstant.selectedTypeKey);
  }
}
