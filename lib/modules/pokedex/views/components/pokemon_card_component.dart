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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: BorderSide(
            color:
                Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black,
            width: 1,
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 100.h,
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pokemon.name ?? "Pokemon",
                        style: TextStyle(
                          fontSize: 21.sp,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      ElementChipsComponent(
                        elements: pokemon.typeofpokemon ?? [],
                        size: ChipSize.medium,
                        maxElementsToShow: 2,
                        clipText: (pokemon.typeofpokemon?.length ?? 0) > 1,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: 100.h,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(16.r),
                            bottomRight: Radius.circular(16.r),
                          ),
                          color: pokemon.color,
                        ),
                        alignment: Alignment.center,
                        child: Center(
                          child: SizedBox(
                            width: 100.w * (80 / 100),
                            height: 100.h * (80 / 100),
                            child: CachedNetworkImage(
                              imageUrl: pokemon.imageurl ?? "",
                              fit: BoxFit.cover,
                              width: 100.w * (80 / 100),
                              height: 100.h * (80 / 100),
                              errorWidget: (context, url, error) {
                                return Assets.svg.icons.pokedexActiveIcon.svg(
                                  width: 100.w * (80 / 100),
                                  height: 100.h * (80 / 100),
                                );
                              },
                              progressIndicatorBuilder: (
                                context,
                                url,
                                progress,
                              ) {
                                return Lottie.asset(
                                  Assets.lotties.pokemonLoadingAnimation.path,
                                  width: 100.w * (80 / 100),
                                  height: 100.h * (80 / 100),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: GestureDetector(
                          onTap: () {
                            onFavoriteToggle?.call(pokemon);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Conditional.single(
                              condition: pokemon.isFavorite ?? false,
                              widget: Assets.svg.icons.favoriteCardActiveIcon
                                  .svg(width: 32.w, height: 32.h),
                              fallback: Assets
                                  .svg
                                  .icons
                                  .favoriteCardInactiveIcon
                                  .svg(width: 32.w, height: 32.h),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
