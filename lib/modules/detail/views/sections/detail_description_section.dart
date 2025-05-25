
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rama_poke_app/modules/detail/controllers/detail_controller.dart';

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