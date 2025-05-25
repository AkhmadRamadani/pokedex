import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:rama_poke_app/core/databases/constants/hive_constant.dart';

class SelectedTypeLocalService {
  Box<String> get _typeBox => Hive.box<String>(HiveConstant.selectedTypeKey);
  static const _key = 'selected_types';

  Future<void> saveSelectedType(String types) => _typeBox.put(_key, types);

  Future<String?> getSelectedType() async => _typeBox.get(_key);

  Future<void> clearSelectedTypes() => _typeBox.clear();
}
