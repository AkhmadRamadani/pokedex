import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:rama_poke_app/core/config/di/di.dart';
import 'package:rama_poke_app/core/databases/local_database.dart';
import 'package:rama_poke_app/pokedex_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  configureDependencies();

  final db = getIt<LocalDatabase>();
  await db.initialize();

  runApp(PokedexProvider(savedThemeMode: savedThemeMode));
}
