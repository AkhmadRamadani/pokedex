import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:rama_poke_app/core/config/di/di.dart';
import 'package:rama_poke_app/modules/detail/controllers/detail_controller.dart';
import 'package:rama_poke_app/modules/favorite/controllers/favorite_controller.dart';
import 'package:rama_poke_app/modules/home/controllers/home_controller.dart';
import 'package:rama_poke_app/modules/pokedex/controllers/pokedex_controller.dart';
import 'package:rama_poke_app/modules/pokedex/controllers/selected_type_controller.dart';
import 'package:rama_poke_app/pokedex_app.dart';

class PokedexProvider extends StatelessWidget {
  const PokedexProvider({super.key, this.savedThemeMode});
  final AdaptiveThemeMode? savedThemeMode;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => DetailController()),
        ChangeNotifierProvider(create: (_) => PokedexController()),
        ChangeNotifierProvider(create: (_) => getIt<FavoriteController>()),
        ChangeNotifierProvider(create: (_) => getIt<SelectedTypeController>()),
      ],
      child: PokedexApp(savedThemeMode: savedThemeMode),
    );
  }
}
