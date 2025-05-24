import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rama_poke_app/core/shared/widgets/custom_app_bar_widget.dart';
import 'package:rama_poke_app/modules/pokedex/views/components/pokemon_card_component.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: "Favorite"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: ListView.separated(
          itemBuilder: (_, index) => const PokemonCardComponent(),
          separatorBuilder: (_, index) => SizedBox(height: 16.h),
          itemCount: 10,
        ),
      ),
    );
  }
}
