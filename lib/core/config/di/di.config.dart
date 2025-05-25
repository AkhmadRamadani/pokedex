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

import '../../../modules/pokedex/repositories/pokedex_repository.dart'
    as _i1024;
import '../../../modules/pokedex/repositories/selected_type_repository.dart'
    as _i45;
import '../../databases/local_database.dart' as _i965;
import '../../databases/mappers/pokemon_data_mapper.dart' as _i496;
import '../../databases/mappers/string_to_pokemon_type_mapper.dart' as _i261;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i496.PokemonDataMapper>(() => _i496.PokemonDataMapper());
    gh.factory<_i261.StringToPokemonTypeMapper>(
      () => _i261.StringToPokemonTypeMapper(),
    );
    gh.factory<_i1024.PokedexRepository>(() => _i1024.PokedexRepository());
    gh.factory<_i45.SelectedTypeRepository>(
      () => _i45.SelectedTypeRepository(),
    );
    gh.lazySingleton<_i965.LocalDatabase>(() => _i965.LocalDatabase());
    return this;
  }
}
