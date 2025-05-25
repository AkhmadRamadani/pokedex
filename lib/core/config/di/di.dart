import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:rama_poke_app/core/databases/local_database.dart';
import 'package:rama_poke_app/core/databases/mappers/pokemon_data_mapper.dart';
import 'package:rama_poke_app/core/databases/services/favorite_local_service.dart';
import 'package:rama_poke_app/core/databases/services/pokemon_local_service.dart';
import 'package:rama_poke_app/core/databases/services/selected_type_local_service.dart';
import 'di.config.dart';

final getIt = GetIt.instance;

@module
abstract class DatabaseModule {
  @singleton
  LocalDatabase get localDatabase => LocalDatabase();

  @singleton
  FavoriteLocalService get favoriteLocalService => FavoriteLocalService();

  @singleton
  PokemonLocalService get pokemonLocalService => PokemonLocalService();

  @singleton
  PokemonDataMapper get pokemonDataMapper => PokemonDataMapper();

  @singleton
  SelectedTypeLocalService get selectedTypeLocalService =>
      SelectedTypeLocalService();
}

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDependencies() => getIt.init();
