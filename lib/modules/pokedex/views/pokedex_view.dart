import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rama_poke_app/core/config/route_config.gr.dart';
import 'package:rama_poke_app/core/shared/widgets/app_search_app_bar_widget.dart';
import 'package:rama_poke_app/modules/pokedex/views/components/button_type_component.dart';
import 'package:rama_poke_app/modules/pokedex/views/components/pokemon_card_component.dart';

class PokedexView extends StatelessWidget {
  const PokedexView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppSearchAppBarWidget(title: "Find the Pokemon"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: 16.h),
              ButtonTypeComponent(),
              SizedBox(height: 16.h),
              ListView.separated(
                itemBuilder:
                    (_, index) => PokemonCardComponent(
                      onTap: () {
                        context.pushRoute(DetailRoute(id: '$index'));
                      },
                    ),
                separatorBuilder: (_, index) => SizedBox(height: 16.h),
                itemCount: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
