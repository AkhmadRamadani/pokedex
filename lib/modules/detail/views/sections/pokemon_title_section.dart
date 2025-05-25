import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rama_poke_app/modules/detail/controllers/detail_controller.dart';
import 'package:rama_poke_app/modules/pokedex/views/components/element_chips_component.dart';

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
