import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rama_poke_app/core/assets/element/element_color.dart';
import 'package:rama_poke_app/core/assets/gen/assets.gen.dart';

class ElementAsset {
  ElementAsset._();

  static SvgPicture water({
    double width = 24,
    double height = 24,
    Color? color,
  }) => Assets.svg.elements.waterElement.svg(
    width: width,
    height: height,
    colorFilter: ColorFilter.mode(
      color ?? ElementColor.waterElement,
      BlendMode.srcIn,
    ),
  );

  static SvgPicture dragon({
    double width = 24,
    double height = 24,
    Color? color,
  }) => Assets.svg.elements.dragonElement.svg(
    width: width,
    height: height,
    colorFilter: ColorFilter.mode(
      color ?? ElementColor.dragonElement,
      BlendMode.srcIn,
    ),
  );

  static SvgPicture electric({
    double width = 24,
    double height = 24,
    Color? color,
  }) => Assets.svg.elements.electricElement.svg(
    width: width,
    height: height,
    colorFilter: ColorFilter.mode(
      color ?? ElementColor.electricElement,
      BlendMode.srcIn,
    ),
  );

  static SvgPicture fairy({
    double width = 24,
    double height = 24,
    Color? color,
  }) => Assets.svg.elements.fairyElement.svg(
    width: width,
    height: height,
    colorFilter: ColorFilter.mode(
      color ?? ElementColor.fairyElement,
      BlendMode.srcIn,
    ),
  );

  static SvgPicture ghost({
    double width = 24,
    double height = 24,
    Color? color,
  }) => Assets.svg.elements.ghostElement.svg(
    width: width,
    height: height,
    colorFilter: ColorFilter.mode(
      color ?? ElementColor.ghostElement,
      BlendMode.srcIn,
    ),
  );

  static SvgPicture fire({
    double width = 24,
    double height = 24,
    Color? color,
  }) => Assets.svg.elements.fireElement.svg(
    width: width,
    height: height,
    colorFilter: ColorFilter.mode(
      color ?? ElementColor.fireElement,
      BlendMode.srcIn,
    ),
  );

  static SvgPicture ice({
    double width = 24,
    double height = 24,
    Color? color,
  }) => Assets.svg.elements.iceElement.svg(
    width: width,
    height: height,
    colorFilter: ColorFilter.mode(
      color ?? ElementColor.iceElement,
      BlendMode.srcIn,
    ),
  );

  static SvgPicture grass({
    double width = 24,
    double height = 24,
    Color? color,
  }) => Assets.svg.elements.grassElement.svg(
    width: width,
    height: height,
    colorFilter: ColorFilter.mode(
      color ?? ElementColor.grassElement,
      BlendMode.srcIn,
    ),
  );

  static SvgPicture insect({
    double width = 24,
    double height = 24,
    Color? color,
  }) => Assets.svg.elements.insectElement.svg(
    width: width,
    height: height,
    colorFilter: ColorFilter.mode(
      color ?? ElementColor.insectElement,
      BlendMode.srcIn,
    ),
  );

  static SvgPicture fighter({
    double width = 24,
    double height = 24,
    Color? color,
  }) => Assets.svg.elements.fighterElement.svg(
    width: width,
    height: height,
    colorFilter: ColorFilter.mode(
      color ?? ElementColor.fighterElement,
      BlendMode.srcIn,
    ),
  );

  static SvgPicture normal({
    double width = 24,
    double height = 24,
    Color? color,
  }) => Assets.svg.elements.normalElement.svg(
    width: width,
    height: height,
    colorFilter: ColorFilter.mode(
      color ?? ElementColor.normalElement,
      BlendMode.srcIn,
    ),
  );

  static SvgPicture nocturnal({
    double width = 24,
    double height = 24,
    Color? color,
  }) => Assets.svg.elements.nocturnalElement.svg(
    width: width,
    height: height,
    colorFilter: ColorFilter.mode(
      color ?? ElementColor.nocturnalElement,
      BlendMode.srcIn,
    ),
  );

  static SvgPicture metal({
    double width = 24,
    double height = 24,
    Color? color,
  }) => Assets.svg.elements.metalElement.svg(
    width: width,
    height: height,
    colorFilter: ColorFilter.mode(
      color ?? ElementColor.metalElement,
      BlendMode.srcIn,
    ),
  );

  static SvgPicture stone({
    double width = 24,
    double height = 24,
    Color? color,
  }) => Assets.svg.elements.stoneElement.svg(
    width: width,
    height: height,
    colorFilter: ColorFilter.mode(
      color ?? ElementColor.stoneElement,
      BlendMode.srcIn,
    ),
  );

  static SvgPicture psychic({
    double width = 24,
    double height = 24,
    Color? color,
  }) => Assets.svg.elements.psychicElement.svg(
    width: width,
    height: height,
    colorFilter: ColorFilter.mode(
      color ?? ElementColor.psychicElement,
      BlendMode.srcIn,
    ),
  );

  static SvgPicture terrestrial({
    double width = 24,
    double height = 24,
    Color? color,
  }) => Assets.svg.elements.terrestrialElement.svg(
    width: width,
    height: height,
    colorFilter: ColorFilter.mode(
      color ?? ElementColor.terrestrialElement,
      BlendMode.srcIn,
    ),
  );

  static SvgPicture poisonous({
    double width = 24,
    double height = 24,
    Color? color,
  }) => Assets.svg.elements.poisonousElement.svg(
    width: width,
    height: height,
    colorFilter: ColorFilter.mode(
      color ?? ElementColor.poisonousElement,
      BlendMode.srcIn,
    ),
  );

  static SvgPicture flying({
    double width = 24,
    double height = 24,
    Color? color,
  }) => Assets.svg.elements.flyingElement.svg(
    width: width,
    height: height,
    colorFilter: ColorFilter.mode(
      color ?? ElementColor.flyingElement,
      BlendMode.srcIn,
    ),
  );
}
