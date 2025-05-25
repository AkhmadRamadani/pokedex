import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rama_poke_app/core/config/route_config.dart';
import 'package:rama_poke_app/core/themes/themes/dark_theme.dart';
import 'package:rama_poke_app/core/themes/themes/light_theme.dart';

class PokedexApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  PokedexApp({super.key, this.savedThemeMode});

  final _routeConfig = RouteConfig();

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: lightTheme,
      dark: darkTheme,
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      debugShowFloatingThemeButton: true,
      builder:
          (theme, darkTheme) => ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            child: MaterialApp.router(
              title: 'Pokedex',
              theme: theme,
              darkTheme: darkTheme,
              routerConfig: _routeConfig.config(),
              builder: (context, child) {
                return GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: child,
                );
              },
            ),
          ),
    );
  }
}
