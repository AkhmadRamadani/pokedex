import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rama_poke_app/modules/detail/controllers/detail_controller.dart';
import 'package:rama_poke_app/modules/pokedex/views/components/element_chips_component.dart';

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
