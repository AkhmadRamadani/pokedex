import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rama_poke_app/core/assets/gen/assets.gen.dart';
import 'package:rama_poke_app/core/config/route_config.gr.dart';
import 'package:rama_poke_app/core/shared/models/pokemon_model.dart';
import 'package:rama_poke_app/core/shared/widgets/app_image_network_widget.dart';
import 'package:rama_poke_app/modules/detail/controllers/detail_controller.dart';
import 'package:rama_poke_app/modules/detail/views/components/collapsed_app_bar_component.dart';
import 'package:rama_poke_app/modules/pokedex/views/components/element_chips_component.dart';

class DetailView extends StatefulWidget {
  const DetailView({super.key, required this.id});
  final String id;

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  final ScrollController _scrollController = ScrollController();
  late DetailController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<DetailController>();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          DetailAppBarSection(scrollController: _scrollController),
          DetailContentSection(),
        ],
      ),
    );
  }
}

class DetailAppBarSection extends StatelessWidget {
  final ScrollController scrollController;

  const DetailAppBarSection({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailController>(
      builder: (context, controller, child) {
        return DetailStateHandler(
          pokemonState: controller.pokemonState,
          onLoading:
              () => const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              ),
          onSuccess:
              (pokemon) => CollapsingAppBar(
                scrollController: scrollController,
                pokemon: pokemon,
              ),
          onError: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
        );
      },
    );
  }
}

class DetailStateHandler extends StatelessWidget {
  final dynamic pokemonState;
  final Widget Function() onLoading;
  final Widget Function(dynamic pokemon) onSuccess;
  final Widget Function() onError;

  const DetailStateHandler({
    super.key,
    required this.pokemonState,
    required this.onLoading,
    required this.onSuccess,
    required this.onError,
  });

  @override
  Widget build(BuildContext context) {
    if (pokemonState.isLoading()) {
      return onLoading();
    }

    if (pokemonState.isSuccess()) {
      final dataSuccess = pokemonState.dataSuccess();
      if (dataSuccess != null) {
        return onSuccess(dataSuccess);
      }
    }

    return onError();
  }
}

class DetailContentSection extends StatelessWidget {
  const DetailContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          children: const [
            PokemonTitleSection(),
            PokemonDescriptionSection(),
            PokemonStatsGrid(),
            PokemonGenderSection(),
            PokemonWeaknessSection(),
            PokemonEvolutionSection(),
          ],
        ),
      ]),
    );
  }
}

class PokemonTitleSection extends StatelessWidget {
  const PokemonTitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailController>(
      builder: (context, controller, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _getPokemonName(controller),
              style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 24.h),
            ElementChipsComponent(
              elements:
                  controller.pokemonState.dataSuccess()?.typeofpokemon ?? [],
              size: ChipSize.big,
            ),
            SizedBox(height: 24.h),
          ],
        );
      },
    );
  }

  String _getPokemonName(DetailController controller) {
    if (controller.pokemonState.isSuccess()) {
      final pokemon = controller.pokemonState.dataSuccess();
      return pokemon?.name ?? '';
    }
    return '';
  }
}

// Pokemon Description Section - Single Responsibility: Displays description
class PokemonDescriptionSection extends StatelessWidget {
  const PokemonDescriptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailController>(
      builder: (context, controller, child) {
        return Column(
          children: [
            Text(
              _getPokemonDescription(controller),
              style: TextStyle(
                fontSize: 14.sp,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
            SizedBox(height: 20.h),
            Divider(color: Theme.of(context).dividerColor, thickness: 1),
            SizedBox(height: 20.h),
          ],
        );
      },
    );
  }

  String _getPokemonDescription(DetailController controller) {
    if (controller.pokemonState.isSuccess()) {
      final pokemon = controller.pokemonState.dataSuccess();
      return pokemon?.xdescription ?? "";
    }
    return "";
  }
}

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

class PokemonStatItem extends StatelessWidget {
  final PokemonStat stat;

  const PokemonStatItem({super.key, required this.stat});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            stat.icon.svg(
              width: 12.w,
              height: 12.h,
              colorFilter: ColorFilter.mode(
                Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              stat.label,
              style: TextStyle(
                fontSize: 12.sp,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).dividerColor,
              width: 1.w,
            ),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Text(
            stat.value,
            style: TextStyle(
              fontSize: 18.sp,
              color: Theme.of(context).textTheme.bodyMedium?.color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class PokemonGenderSection extends StatelessWidget {
  const PokemonGenderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailController>(
      builder: (context, controller, child) {
        final genderData = _getGenderData(controller);
        return Visibility(
          visible: controller.pokemonState.dataSuccess()?.genderless == 0,
          child: Column(
            children: [
              GenderPercentIndicator(
                malePercent: genderData.malePercent,
                femalePercent: genderData.femalePercent,
              ),
              SizedBox(height: 40.h),
            ],
          ),
        );
      },
    );
  }

  PokemonGenderData _getGenderData(DetailController controller) {
    return PokemonGenderData(
      malePercent:
          controller.pokemonState.dataSuccess()?.malePercentage ?? 50.0,
      femalePercent:
          controller.pokemonState.dataSuccess()?.femalePercentage ?? 50.0,
    );
  }
}

// Pokemon Weakness Section - Single Responsibility: Displays
class PokemonWeaknessSection extends StatelessWidget {
  const PokemonWeaknessSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailController>(
      builder: (context, controller, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Weakness",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 12.h),
            ElementChipsComponent(
              elements: controller.pokemonState.dataSuccess()?.weaknesses ?? [],
              size: ChipSize.grid,
              useGrid: true,
              chipSpacing: 16.w,
            ),
            SizedBox(height: 20.h),
          ],
        );
      },
    );
  }
}

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

// Evolution Separator - Single Responsibility: Displays arrow between evolutions
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

class PokemonStat {
  final String label;
  final String value;
  final SvgGenImage icon;

  PokemonStat({required this.label, required this.value, required this.icon});
}

class PokemonGenderData {
  final double malePercent;
  final double femalePercent;

  PokemonGenderData({required this.malePercent, required this.femalePercent});
}

class GenderPercentIndicator extends StatelessWidget {
  final double malePercent;
  final double femalePercent;

  const GenderPercentIndicator({
    super.key,
    required this.malePercent,
    required this.femalePercent,
  });

  @override
  Widget build(BuildContext context) {
    assert(
      (malePercent + femalePercent).toStringAsFixed(1) == '100.0',
      'Total percentage must be 100%',
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("GENDER", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Row(
            children: [
              Expanded(
                flex: (malePercent * 10).round(),
                child: Container(height: 10, color: Colors.blue),
              ),
              Expanded(
                flex: (femalePercent * 10).round(),
                child: Container(height: 10, color: Colors.pinkAccent),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.male, size: 18),
                const SizedBox(width: 4),
                Text("${malePercent.toStringAsFixed(1).replaceAll('.', ',')}%"),
              ],
            ),
            Row(
              children: [
                Text(
                  "${femalePercent.toStringAsFixed(1).replaceAll('.', ',')}%",
                ),
                const SizedBox(width: 4),
                const Icon(Icons.female, size: 18),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
