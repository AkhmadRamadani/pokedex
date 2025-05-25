import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional/flutter_conditional.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:rama_poke_app/core/assets/gen/assets.gen.dart';
import 'package:rama_poke_app/core/shared/models/pokemon_model.dart';
import 'package:rama_poke_app/modules/pokedex/views/components/element_chips_component.dart';

class PokemonCardComponent extends StatelessWidget {
  const PokemonCardComponent({
    super.key,
    this.onTap,
    required this.pokemon,
    this.onFavoriteToggle,
  });

  final Function()? onTap;
  final PokemonEntityModel pokemon;
  final Function(PokemonEntityModel)? onFavoriteToggle;

  static const double _cardHeight = 100.0;
  static const double _borderRadius = 16.0;
  static const double _borderWidth = 1.0;
  static const double _horizontalPadding = 16.0;
  static const double _verticalPadding = 12.0;
  static const double _nameVerticalSpacing = 4.0;
  static const double _nameFontSize = 21.0;
  static const double _imageScaleFactor = 0.8;
  static const double _favoriteIconSize = 32.0;
  static const double _favoriteIconPadding = 8.0;
  static const int _contentFlex = 5;
  static const int _imageFlex = 3;
  static const int _maxElementsToShow = 2;
  static const String _defaultPokemonName = "Pokemon";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shadowColor: Colors.transparent,
        shape: _buildCardShape(context),
        child: _buildCardContent(),
      ),
    );
  }

  RoundedRectangleBorder _buildCardShape(BuildContext context) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(_borderRadius.r),
      side: BorderSide(
        color: Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black,
        width: _borderWidth,
      ),
    );
  }

  Widget _buildCardContent() {
    return SizedBox(
      width: double.infinity,
      height: _cardHeight.h,
      child: Row(children: [_buildContentSection(), _buildImageSection()]),
    );
  }

  Widget _buildContentSection() {
    return Expanded(
      flex: _contentFlex,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: _horizontalPadding.w,
          vertical: _verticalPadding.h,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPokemonName(),
            SizedBox(height: _nameVerticalSpacing.h),
            _buildElementChips(),
          ],
        ),
      ),
    );
  }

  Widget _buildPokemonName() {
    return Builder(
      builder:
          (context) => Text(
            pokemon.name ?? _defaultPokemonName,
            style: TextStyle(
              fontSize: _nameFontSize.sp,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
    );
  }

  Widget _buildElementChips() {
    return ElementChipsComponent(
      elements: pokemon.typeofpokemon ?? [],
      size: ChipSize.medium,
      maxElementsToShow: _maxElementsToShow,
      clipText: (pokemon.typeofpokemon?.length ?? 0) > 1,
    );
  }

  Widget _buildImageSection() {
    return Expanded(
      flex: _imageFlex,
      child: SizedBox(
        height: _cardHeight.h,
        child: Stack(
          children: [_buildImageContainer(), _buildFavoriteButton()],
        ),
      ),
    );
  }

  Widget _buildImageContainer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(_borderRadius.r),
          bottomRight: Radius.circular(_borderRadius.r),
        ),
        color: pokemon.color,
      ),
      alignment: Alignment.center,
      child: _buildPokemonImage(),
    );
  }

  Widget _buildPokemonImage() {
    final imageSize = _cardHeight * _imageScaleFactor;

    return SizedBox(
      width: imageSize.w,
      height: imageSize.h,
      child: CachedNetworkImage(
        imageUrl: pokemon.imageurl ?? "",
        fit: BoxFit.cover,
        width: imageSize.w,
        height: imageSize.h,
        errorWidget: (context, url, error) => _buildErrorWidget(imageSize),
        progressIndicatorBuilder:
            (context, url, progress) => _buildLoadingWidget(imageSize),
      ),
    );
  }

  Widget _buildErrorWidget(double size) {
    return Assets.svg.icons.pokedexActiveIcon.svg(
      width: size.w,
      height: size.h,
    );
  }

  Widget _buildLoadingWidget(double size) {
    return Lottie.asset(
      Assets.lotties.pokemonLoadingAnimation.path,
      width: size.w,
      height: size.h,
    );
  }

  Widget _buildFavoriteButton() {
    return Positioned(
      right: 0,
      top: 0,
      child: GestureDetector(
        onTap: () => _handleFavoriteToggle(),
        child: Padding(
          padding: EdgeInsets.all(_favoriteIconPadding.w),
          child: _buildFavoriteIcon(),
        ),
      ),
    );
  }

  void _handleFavoriteToggle() {
    onFavoriteToggle?.call(pokemon);
  }

  Widget _buildFavoriteIcon() {
    final isFavorite = pokemon.isFavorite ?? false;

    return Conditional.single(
      condition: isFavorite,
      widget: _buildActiveFavoriteIcon(),
      fallback: _buildInactiveFavoriteIcon(),
    );
  }

  Widget _buildActiveFavoriteIcon() {
    return Assets.svg.icons.favoriteCardActiveIcon.svg(
      width: _favoriteIconSize.w,
      height: _favoriteIconSize.h,
    );
  }

  Widget _buildInactiveFavoriteIcon() {
    return Assets.svg.icons.favoriteCardInactiveIcon.svg(
      width: _favoriteIconSize.w,
      height: _favoriteIconSize.h,
    );
  }
}
