
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rama_poke_app/core/assets/gen/assets.gen.dart';
import 'package:rama_poke_app/modules/detail/controllers/detail_controller.dart';
import 'package:rama_poke_app/modules/detail/views/sections/pokemon_stat_item.dart';

class PokemonStatsGrid extends StatelessWidget {
  const PokemonStatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailController>(
      builder: (context, controller, child) {
        return Column(
          children: [
            GridView(
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.h,
                childAspectRatio: 2.5,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: _buildStatItems(context, controller),
            ),
            SizedBox(height: 20.h),
          ],
        );
      },
    );
  }

  List<Widget> _buildStatItems(
    BuildContext context,
    DetailController controller,
  ) {
    final stats = _getPokemonStats(controller);
    return stats.map((stat) => PokemonStatItem(stat: stat)).toList();
  }

  List<PokemonStat> _getPokemonStats(DetailController controller) {
    return [
      PokemonStat(
        label: "Weight",
        value: controller.pokemonState.dataSuccess()?.weight ?? "",
        icon: Assets.svg.icons.weightIcon,
      ),
      PokemonStat(
        label: "Height",
        value: controller.pokemonState.dataSuccess()?.height ?? "",
        icon: Assets.svg.icons.heightIcon,
      ),
      PokemonStat(
        label: "Category",
        value: controller.pokemonState.dataSuccess()?.category ?? "",
        icon: Assets.svg.icons.categoryIcon,
      ),
      PokemonStat(
        label: "Ability",
        value: (controller.pokemonState.dataSuccess()?.abilities ?? []).first,
        icon: Assets.svg.icons.pokedexInactiveIcon,
      ),
    ];
  }
}