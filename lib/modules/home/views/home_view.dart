import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rama_poke_app/modules/favorite/views/favorite_view.dart';
import 'package:rama_poke_app/modules/home/controllers/home_controller.dart';
import 'package:rama_poke_app/modules/pokedex/views/pokedex_view.dart';

@RoutePage()
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  final List<Widget> pages = const [
    PokedexView(),
    FavoriteView(),
  ];

  @override
  Widget build(BuildContext context) {
    final homeController = context.watch<HomeController>();
    return Scaffold(
      body: IndexedStack(
        index: homeController.currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: homeController.currentIndex,
        items: homeController.destinations,
        onTap: (index) => homeController.changeIndex(index),
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        
      ),
    );
  }
}
