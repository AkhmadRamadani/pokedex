import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rama_poke_app/core/config/di/di.dart';
import 'package:rama_poke_app/core/databases/local_database.dart';
import 'package:rama_poke_app/core/databases/mappers/string_to_pokemon_type_mapper.dart';
import 'package:rama_poke_app/core/shared/models/pokemon_model.dart';

@injectable
class SelectedTypeRepository {
  final db = getIt<LocalDatabase>();
  final mapper = getIt<StringToPokemonTypeMapper>();

  Future<Either<String, TypeOfPokemon>> getSelectedTypeOfPokemon() async {
    try {
      final data = await db.getSelectedType();
      if (data.isEmpty) return Left("Data Still Empty");
      final result = mapper.map(data);

      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<void> removeSelectedTypeOfPokemon() async {
    await db.clearSelectedTypes();
  }

  Future<void> addSelectedTypeOfPokemon(TypeOfPokemon type) async {
    await db.saveSelectedType(type.name);
  }
}
