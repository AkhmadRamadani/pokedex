import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rama_poke_app/modules/detail/views/sections/detail_description_section.dart';
import 'package:rama_poke_app/modules/detail/views/sections/pokemon_evolution_section.dart';
import 'package:rama_poke_app/modules/detail/views/sections/pokemon_gender_section.dart';
import 'package:rama_poke_app/modules/detail/views/sections/pokemon_stats_grid.dart';
import 'package:rama_poke_app/modules/detail/views/sections/pokemon_title_section.dart';
import 'package:rama_poke_app/modules/detail/views/sections/pokemon_weakness_section.dart';

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
