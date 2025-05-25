import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rama_poke_app/core/config/route_config.gr.dart';
import 'package:rama_poke_app/core/extensions/color_extension.dart';
import 'package:rama_poke_app/core/shared/widgets/app_empty_widget.dart';
import 'package:rama_poke_app/core/shared/widgets/app_search_app_bar_widget.dart';
import 'package:rama_poke_app/core/shared/widgets/app_shimmer_widget.dart';
import 'package:rama_poke_app/modules/pokedex/controllers/pokedex_controller.dart';
import 'package:rama_poke_app/modules/pokedex/views/components/button_type_component.dart';
import 'package:rama_poke_app/modules/pokedex/views/components/pokemon_card_component.dart';

class PokedexView extends StatefulWidget {
  const PokedexView({super.key});

  @override
  State<PokedexView> createState() => _PokedexViewState();
}

class _PokedexViewState extends State<PokedexView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    PokedexController controller = context.read<PokedexController>();
    controller.refresh();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !controller.pokemonsState.isLoading() &&
          controller.hasMore) {
        controller.fetchPokemons(loadMore: true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PokedexController>();
    final state = controller.pokemonsState;

    return Scaffold(
      appBar: AppSearchAppBarWidget(
        title: "Find the Pokemon",
        onSearch: (query) {
          controller.setNameFilter(query);
        },
        controller: controller.searchController,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.refresh();
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                SizedBox(height: 16.h),
                ButtonTypeComponent(),
                SizedBox(height: 16.h),
                if (controller.hasActiveFilters)
                  Container(
                    padding: EdgeInsets.all(8.w),
                    margin: EdgeInsets.only(bottom: 16.h),
                    decoration: BoxDecoration(
                      color: Colors.blue.withAlphaFromOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.filter_list, size: 16.sp),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            'Active filters: '
                            '${controller.selectedTypeController.selectedType != null ? 'Type: ${controller.selectedTypeController.selectedType?.name ?? ""}' : ''}'
                            '${controller.nameFilter != null ? ', Name: ${controller.nameFilter}' : ''}',
                            style: TextStyle(fontSize: 12.sp),
                          ),
                        ),
                        GestureDetector(
                          onTap: controller.clearFilters,
                          child: Icon(Icons.clear, size: 16.sp),
                        ),
                      ],
                    ),
                  ),
                Builder(
                  builder: (_) {
                    if (state.isLoading()) {
                      return CustomShimmerWidget().list(length: 10);
                    } else if (state.isSuccess()) {
                      final pokemons = state.dataSuccess() ?? [];
                      if (pokemons.isEmpty) {
                        return AppEmptyWidget.custom(
                          titleText: "Noooo, there is no pokemon here",
                          descText: "Can you try another filter?",
                          heightImage: 100.h,
                          widthImage: 100.w,
                          customHeightContent: 0.5.sh,
                          onRefresh: () {
                            controller.refresh();
                          },
                        );
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
                              controller.toggleFavorite(context, pokemon);
                            },
                          );
                        },
                        separatorBuilder: (_, index) => SizedBox(height: 12.h),
                        itemCount: pokemons.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                      );
                    } else if (state.isError()) {
                      return AppEmptyWidget.custom(
                        titleText: "Something went wrong",
                        descText: "Can you try again?",
                        heightImage: 100.h,
                        widthImage: 100.w,
                        customHeightContent: 0.5.sh,
                        onRefresh: () {
                          controller.refresh();
                        },
                      );
                    } else if (state.isEmpty()) {
                      return AppEmptyWidget.custom(
                        titleText: "Noooo, there is no pokemon here",
                        descText: "Can you try another filter?",
                        heightImage: 100.h,
                        widthImage: 100.w,
                        customHeightContent: 0.5.sh,
                        onRefresh: () {
                          controller.refresh();
                        },
                      );
                    }

                    return SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
