import 'package:flutter/material.dart';
import 'package:rama_poke_app/core/assets/gen/assets.gen.dart';

class HomeController extends ChangeNotifier {
  int currentIndex = 0;

  List<BottomNavigationBarItem> destinations = [
    BottomNavigationBarItem(
      icon: Assets.svg.icons.pokedexInactiveIcon.svg(),
      activeIcon: Assets.svg.icons.pokedexActiveIcon.svg(),
      label: 'Pokedéx',
    ),
    BottomNavigationBarItem(
      icon: Assets.svg.icons.favoriteBottomNavBarInactiveIcon.svg(),
      activeIcon: Assets.svg.icons.favoriteBottomNavBarActiveIcon.svg(),
      label: 'Favorite',
    ),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void resetIndex() {
    if (currentIndex != 0) {
      currentIndex = 0;
      notifyListeners();
    }
  }
}
