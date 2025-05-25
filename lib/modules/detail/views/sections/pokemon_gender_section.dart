import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rama_poke_app/modules/detail/controllers/detail_controller.dart';
import 'package:rama_poke_app/modules/detail/views/components/gender_percent_indicator.dart';

class PokemonGenderData {
  final double malePercent;
  final double femalePercent;

  PokemonGenderData({required this.malePercent, required this.femalePercent});
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
