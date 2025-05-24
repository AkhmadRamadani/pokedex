import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:rama_poke_app/modules/home/controllers/home_controller.dart';
import 'package:rama_poke_app/pokedex_app.dart';

class PokedexProvider extends StatelessWidget {
  const PokedexProvider({super.key, this.savedThemeMode});
  final AdaptiveThemeMode? savedThemeMode;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => HomeController())],
      child: PokedexApp(savedThemeMode: savedThemeMode),
    );
  }
}
