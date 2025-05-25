import 'package:flutter/material.dart';
import 'package:rama_poke_app/core/assets/element/element_asset.dart';
import 'package:rama_poke_app/core/assets/element/element_color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rama_poke_app/core/shared/models/pokemon_model.dart';

extension TypeOfPokemonExtension on TypeOfPokemon {
  String get name {
    switch (this) {
      case TypeOfPokemon.bug:
        return 'Insect';
      case TypeOfPokemon.dark:
        return 'Nocturnal';
      case TypeOfPokemon.dragon:
        return 'Dragon';
      case TypeOfPokemon.electric:
        return 'Electric';
      case TypeOfPokemon.fairy:
        return 'Fairy';
      case TypeOfPokemon.fighting:
        return 'Fighter';
      case TypeOfPokemon.fire:
        return 'Fire';
      case TypeOfPokemon.flying:
        return 'Flying';
      case TypeOfPokemon.ghost:
        return 'Ghost';
      case TypeOfPokemon.grass:
        return 'Grass';
      case TypeOfPokemon.ground:
        return 'Terrestrial';
      case TypeOfPokemon.ice:
        return 'Ice';
      case TypeOfPokemon.normal:
        return 'Normal';
      case TypeOfPokemon.poison:
        return 'Poisonous';
      case TypeOfPokemon.psychic:
        return 'Psychic';
      case TypeOfPokemon.rock:
        return 'Stone';
      case TypeOfPokemon.steel:
        return 'Metal';
      case TypeOfPokemon.water:
        return 'Water';
    }
  }

  Color get color {
    switch (this) {
      case TypeOfPokemon.bug:
        return ElementColor.insectElement;
      case TypeOfPokemon.dark:
        return ElementColor.nocturnalElement;
      case TypeOfPokemon.dragon:
        return ElementColor.dragonElement;
      case TypeOfPokemon.electric:
        return ElementColor.electricElement;
      case TypeOfPokemon.fairy:
        return ElementColor.fairyElement;
      case TypeOfPokemon.fighting:
        return ElementColor.fighterElement;
      case TypeOfPokemon.fire:
        return ElementColor.fireElement;
      case TypeOfPokemon.flying:
        return ElementColor.flyingElement;
      case TypeOfPokemon.ghost:
        return ElementColor.ghostElement;
      case TypeOfPokemon.grass:
        return ElementColor.grassElement;
      case TypeOfPokemon.ground:
        return ElementColor.terrestrialElement;
      case TypeOfPokemon.ice:
        return ElementColor.iceElement;
      case TypeOfPokemon.normal:
        return ElementColor.normalElement;
      case TypeOfPokemon.poison:
        return ElementColor.poisonousElement;
      case TypeOfPokemon.psychic:
        return ElementColor.psychicElement;
      case TypeOfPokemon.rock:
        return ElementColor.stoneElement;
      case TypeOfPokemon.steel:
        return ElementColor.metalElement;
      case TypeOfPokemon.water:
        return ElementColor.waterElement;
    }
  }

  SvgPicture? icon(double width, double height, Color? color) {
    switch (this) {
      case TypeOfPokemon.bug:
        return ElementAsset.insect(width: width, height: height, color: color);
      case TypeOfPokemon.dark:
        return ElementAsset.nocturnal(
          width: width,
          height: height,
          color: color,
        );
      case TypeOfPokemon.dragon:
        return ElementAsset.dragon(width: width, height: height, color: color);
      case TypeOfPokemon.electric:
        return ElementAsset.electric(
          width: width,
          height: height,
          color: color,
        );
      case TypeOfPokemon.fairy:
        return ElementAsset.fairy(width: width, height: height, color: color);
      case TypeOfPokemon.fighting:
        return ElementAsset.fighter(width: width, height: height, color: color);
      case TypeOfPokemon.fire:
        return ElementAsset.fire(width: width, height: height, color: color);
      case TypeOfPokemon.flying:
        return ElementAsset.flying(width: width, height: height, color: color);
      case TypeOfPokemon.ghost:
        return ElementAsset.ghost(width: width, height: height, color: color);
      case TypeOfPokemon.grass:
        return ElementAsset.grass(width: width, height: height, color: color);
      case TypeOfPokemon.ground:
        return ElementAsset.terrestrial(
          width: width,
          height: height,
          color: color,
        );
      case TypeOfPokemon.ice:
        return ElementAsset.ice(width: width, height: height, color: color);

      case TypeOfPokemon.normal:
        return ElementAsset.normal(width: width, height: height, color: color);
      case TypeOfPokemon.poison:
        return ElementAsset.poisonous(
          width: width,
          height: height,
          color: color,
        );
      case TypeOfPokemon.psychic:
        return ElementAsset.psychic(width: width, height: height, color: color);
      case TypeOfPokemon.rock:
        return ElementAsset.stone(width: width, height: height, color: color);
      case TypeOfPokemon.steel:
        return ElementAsset.metal(width: width, height: height, color: color);
      case TypeOfPokemon.water:
        return ElementAsset.water(width: width, height: height, color: color);
    }
  }
}
