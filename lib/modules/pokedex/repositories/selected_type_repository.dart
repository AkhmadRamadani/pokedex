import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rama_poke_app/core/config/di/di.dart';
import 'package:rama_poke_app/core/databases/mappers/string_to_pokemon_type_mapper.dart';
import 'package:rama_poke_app/core/databases/services/selected_type_local_service.dart';
import 'package:rama_poke_app/core/shared/models/pokemon_model.dart';

@injectable
class SelectedTypeRepository {
  final selectedTypeDb = getIt<SelectedTypeLocalService>();
  final mapper = getIt<StringToPokemonTypeMapper>();

  Future<Either<String, TypeOfPokemon>> getSelectedTypeOfPokemon() async {
    try {
      final data = await selectedTypeDb.getSelectedType();
      if (data == null) return Left("Data Still Empty");
      final result = mapper.map(data);

      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<void> removeSelectedTypeOfPokemon() async {
    await selectedTypeDb.clearSelectedTypes();
  }

  Future<void> addSelectedTypeOfPokemon(TypeOfPokemon type) async {
    await selectedTypeDb.saveSelectedType(type.name);
  }
}
