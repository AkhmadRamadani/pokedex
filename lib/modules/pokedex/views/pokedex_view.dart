import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rama_poke_app/core/config/route_config.gr.dart';
import 'package:rama_poke_app/core/extensions/color_extension.dart';
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

  late PokedexController controller;

  @override
  void initState() {
    super.initState();

    controller = context.read<PokedexController>();
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
    return Scaffold(
      appBar: AppSearchAppBarWidget(
        title: "Find the Pokemon",
        onSearch: (p0) {
          controller.setNameFilter(p0);
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
                Consumer<PokedexController>(
                  builder: (context, controller, child) {
                    if (controller.hasActiveFilters) {
                      return Column(
                        children: [
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
                                    'Active filters: ${controller.selectedType != null ? 'Type: ${controller.selectedType?.name ?? ""}' : ''} ${controller.nameFilter != null ? ', Name: ${controller.nameFilter}' : ''}',
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
                        ],
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
                Consumer<PokedexController>(
                  builder: (context, controller, child) {
                    final state = controller.pokemonsState;

                    if (state.isLoading()) {
                      return CustomShimmerWidget().list(length: 10);
                    } else if (state.isSuccess()) {
                      final pokemons = state.dataSuccess() ?? [];
                      if ((pokemons).isEmpty) {
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
                          );
                        },
                        separatorBuilder: (_, index) => SizedBox(height: 12.h),
                        itemCount: pokemons.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                      );
                    } else if (state.isError()) {
                      return Text(
                        controller.pokemonsState.messageError() ??
                            "There has been an error",
                      );
                    } else if (state.isEmpty()) {
                      return Text('No Data');
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
