// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../../modules/favorite/controllers/favorite_controller.dart'
    as _i979;
import '../../../modules/favorite/repositories/favorite_repository.dart'
    as _i249;
import '../../../modules/pokedex/controllers/selected_type_controller.dart'
    as _i383;
import '../../../modules/pokedex/repositories/pokedex_repository.dart'
    as _i1024;
import '../../../modules/pokedex/repositories/selected_type_repository.dart'
    as _i45;
import '../../databases/local_database.dart' as _i965;
import '../../databases/mappers/pokemon_data_mapper.dart' as _i496;
import '../../databases/mappers/string_to_pokemon_type_mapper.dart' as _i261;
import '../../databases/services/favorite_local_service.dart' as _i477;
import '../../databases/services/pokemon_local_service.dart' as _i444;
import '../../databases/services/selected_type_local_service.dart' as _i813;
import 'di.dart' as _i913;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final databaseModule = _$DatabaseModule();
    gh.factory<_i249.FavoriteRepository>(() => _i249.FavoriteRepository());
    gh.factory<_i1024.PokedexRepository>(() => _i1024.PokedexRepository());
    gh.factory<_i45.SelectedTypeRepository>(
      () => _i45.SelectedTypeRepository(),
    );
    gh.singleton<_i261.StringToPokemonTypeMapper>(
      () => _i261.StringToPokemonTypeMapper(),
    );
    gh.singleton<_i965.LocalDatabase>(() => databaseModule.localDatabase);
    gh.singleton<_i477.FavoriteLocalService>(
      () => databaseModule.favoriteLocalService,
    );
    gh.singleton<_i444.PokemonLocalService>(
      () => databaseModule.pokemonLocalService,
    );
    gh.singleton<_i496.PokemonDataMapper>(
      () => databaseModule.pokemonDataMapper,
    );
    gh.singleton<_i813.SelectedTypeLocalService>(
      () => databaseModule.selectedTypeLocalService,
    );
    gh.singleton<_i979.FavoriteController>(() => _i979.FavoriteController());
    gh.singleton<_i383.SelectedTypeController>(
      () => _i383.SelectedTypeController(),
    );
    return this;
  }
}

class _$DatabaseModule extends _i913.DatabaseModule {}
