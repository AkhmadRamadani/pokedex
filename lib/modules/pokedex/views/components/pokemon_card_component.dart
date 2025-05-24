import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rama_poke_app/core/assets/element/element_color.dart';
import 'package:rama_poke_app/core/assets/gen/assets.gen.dart';
import 'package:rama_poke_app/modules/pokedex/views/components/element_chips_component.dart';

class PokemonCardComponent extends StatelessWidget {
  const PokemonCardComponent({super.key, this.onTap});
  final Function()? onTap;

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
                flex: 3,
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
                        "Charizard",
                        style: TextStyle(
                          fontSize: 21.sp,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      ElementChipsComponent(
                        elements: ["Fire", "Fire", "Water"],
                        size: ChipSize.medium,
                        maxElementsToShow: 1,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
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
                          color: ElementColor.fireElement,
                        ),
                        alignment: Alignment.center,
                        child: Center(
                          child: SizedBox(
                            width: 100.w * (80 / 100),
                            height: 100.h * (80 / 100),
                            child: Assets.images.dummies.charizard.image(
                              width: 100.w * (80 / 100),
                              height: 100.h * (80 / 100),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Padding(
                          padding: EdgeInsets.all(8.w),
                          child: Assets.svg.icons.favoriteCardActiveIcon.svg(
                            width: 32.w,
                            height: 32.h,
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
