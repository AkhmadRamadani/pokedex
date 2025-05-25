import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rama_poke_app/core/config/route_config.gr.dart';
import 'package:rama_poke_app/core/shared/widgets/app_shimmer_widget.dart';
import 'package:rama_poke_app/core/shared/widgets/custom_app_bar_widget.dart';
import 'package:rama_poke_app/modules/favorite/controllers/favorite_controller.dart';
import 'package:rama_poke_app/modules/pokedex/views/components/pokemon_card_component.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  @override
  void initState() {
    super.initState();

    // Safe way to use context in initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = context.read<FavoriteController>();
      controller.getFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<FavoriteController>();
    final state = controller.favoriteState;

    return Scaffold(
      appBar: CustomAppBarWidget(title: "Favorite"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Builder(
          builder: (_) {
            if (state.isLoading()) {
              return CustomShimmerWidget().list(length: 10);
            } else if (state.isSuccess()) {
              final pokemons = state.dataSuccess() ?? [];
              if (pokemons.isEmpty) {
                return Text('No Data');
              }
              return ListView.separated(
                itemBuilder: (_, index) {
                  final pokemon = pokemons[index];
                  return PokemonCardComponent(
                    pokemon: pokemon,
                    onTap: () {
                      context.pushRoute(
                        DetailWrapperRoute(id: pokemon.id ?? ""),
                      );
                    },
                    onFavoriteToggle: (pokemon) {
                      controller.toggleFavorite(
                        context,
                        pokemon.id ?? "",
                        pokemon.isFavorite ?? false,
                      );
                    },
                  );
                },
                separatorBuilder: (_, index) => SizedBox(height: 12.h),
                itemCount: pokemons.length,
              );
            } else if (state.isError()) {
              return Text(
                controller.favoriteState.messageError() ??
                    "There has been an error",
              );
            } else if (state.isEmpty()) {
              return Text('No Data');
            }

            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
