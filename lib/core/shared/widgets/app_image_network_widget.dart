import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:rama_poke_app/core/assets/gen/assets.gen.dart';

class AppImageNetworkWidget extends StatelessWidget {
  const AppImageNetworkWidget({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.errorWidget,
    this.progressIndicator,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget Function(BuildContext, String, dynamic)? errorWidget;
  final Widget Function(BuildContext, String, DownloadProgress)?
  progressIndicator;

  @override
  Widget build(BuildContext context) {
    final double imageWidth = width ?? 100.w * 0.8;
    final double imageHeight = height ?? 100.h * 0.8;

    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      width: imageWidth,
      height: imageHeight,
      errorWidget:
          errorWidget ??
          (context, url, error) => Assets.svg.icons.pokedexActiveIcon.svg(
            width: imageWidth,
            height: imageHeight,
          ),
      progressIndicatorBuilder:
          progressIndicator ??
          (context, url, progress) => Lottie.asset(
            Assets.lotties.pokemonLoadingAnimation.path,
            width: imageWidth,
            height: imageHeight,
          ),
    );
  }
}
