import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rama_poke_app/core/assets/gen/assets.gen.dart';
import 'package:rama_poke_app/core/config/route_config.gr.dart';
import 'package:rama_poke_app/core/shared/models/pokemon_model.dart';
import 'package:rama_poke_app/core/shared/widgets/app_image_network_widget.dart';
import 'package:rama_poke_app/modules/detail/controllers/detail_controller.dart';
import 'package:rama_poke_app/modules/pokedex/views/components/element_chips_component.dart';

class PokemonEvolutionSection extends StatelessWidget {
  const PokemonEvolutionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailController>(
      builder: (context, controller, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Evolution",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 12.h),
            EvolutionChainWidget(
              evolutions:
                  controller.pokemonState.dataSuccess()?.evolutions ?? [],
              currentActiveId: controller.pokemonState.dataSuccess()?.id ?? "",
            ),
          ],
        );
      },
    );
  }
}

class EvolutionChainWidget extends StatelessWidget {
  final List<PokemonEntityModel> evolutions;
  final String currentActiveId;

  const EvolutionChainWidget({
    super.key,
    required this.evolutions,
    required this.currentActiveId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Theme.of(context).dividerColor, width: 1.w),
      ),
      child: ListView.separated(
        itemBuilder: (context, index) {
          final evolution = evolutions[index];
          return EvolutionItem(
            evolution: evolution,
            onTap: () {
              if (evolution.id == currentActiveId) return;
              context.pushRoute(DetailWrapperRoute(id: evolution.id ?? ""));
            },
          );
        },
        separatorBuilder: (context, index) => EvolutionSeparator(),
        itemCount: evolutions.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
      ),
    );
  }
}

class EvolutionItem extends StatelessWidget {
  final PokemonEntityModel evolution;
  final Function()? onTap;

  const EvolutionItem({super.key, required this.evolution, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90.r),
          border: Border.all(color: Theme.of(context).dividerColor, width: 1.w),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: evolution.color,
                  borderRadius: BorderRadius.circular(90.r),
                ),

                child: AppImageNetworkWidget(
                  imageUrl: evolution.imageurl ?? "",
                  height: 72.h,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    evolution.name ?? "",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  ElementChipsComponent(
                    elements: evolution.typeofpokemon ?? [],
                    size: ChipSize.simple,
                    maxElementsToShow: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EvolutionSeparator extends StatelessWidget {
  const EvolutionSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Assets.svg.icons.arrowDownIcon.svg(width: 18.w),
    );
  }
}
