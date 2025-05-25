import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rama_poke_app/core/config/di/di.dart';
import 'package:rama_poke_app/core/shared/models/pokemon_model.dart';
import 'package:rama_poke_app/modules/pokedex/repositories/selected_type_repository.dart';

@singleton
class SelectedTypeController extends ChangeNotifier {
  final SelectedTypeRepository _repository = getIt<SelectedTypeRepository>();

  TypeOfPokemon? _selectedType;
  TypeOfPokemon? get selectedType => _selectedType;

  Future<void> fetchSelectedType() async {
    final result = await _repository.getSelectedTypeOfPokemon();
    result.fold((_) => _selectedType = null, (data) => _selectedType = data);
    notifyListeners();
  }

  Future<void> setSelectedType(TypeOfPokemon? type) async {
    if (type == null) {
      await _repository.removeSelectedTypeOfPokemon();
      _selectedType = null;
    } else {
      await _repository.addSelectedTypeOfPokemon(type);
      _selectedType = type;
    }
    notifyListeners();
  }
}
