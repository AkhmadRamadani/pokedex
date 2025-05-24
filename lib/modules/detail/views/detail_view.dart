import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rama_poke_app/core/assets/element/element_color.dart';
import 'package:rama_poke_app/core/assets/gen/assets.gen.dart';
import 'package:rama_poke_app/modules/detail/views/components/collapsed_app_bar_component.dart';
import 'package:rama_poke_app/modules/pokedex/views/components/element_chips_component.dart';

@RoutePage()
class DetailView extends StatelessWidget {
  DetailView({super.key, @PathParam('id') required this.id});
  final String id;

  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          CollapsingAppBar(scrollController: _scrollController),
          SliverList(
            delegate: SliverChildListDelegate([
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                children: [
                  Text(
                    'Charizard',
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  ElementChipsComponent(
                    elements: [
                      "Fire",
                      "Metal",
                      "Water",
                      "Grass",
                      "Electric",
                      "Psychic",
                      "Ice",
                      "Dragon",
                    ],
                    maxElementsToShow: 6,
                    size: ChipSize.big,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Bulbasaur can be seen napping in bright sunlight. There is a seed on its back. By soaking up the sun's rays, the seed grows progressively larger.",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Divider(color: Theme.of(context).dividerColor, thickness: 1),
                  SizedBox(height: 20.h),
                  GridView(
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 16.h,
                      childAspectRatio: 2.5,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Assets.svg.icons.weightIcon.svg(
                                width: 12.w,
                                height: 12.h,
                                colorFilter: ColorFilter.mode(
                                  Theme.of(
                                        context,
                                      ).textTheme.bodyMedium?.color ??
                                      Colors.black,
                                  BlendMode.srcIn,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "Weight",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color:
                                      Theme.of(
                                        context,
                                      ).textTheme.bodyMedium?.color,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).dividerColor,
                                width: 1.w,
                              ),
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Text(
                              "15.2 lbs",
                              style: TextStyle(
                                fontSize: 18.sp,
                                color:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.color,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Assets.svg.icons.weightIcon.svg(
                                width: 12.w,
                                height: 12.h,
                                colorFilter: ColorFilter.mode(
                                  Theme.of(
                                        context,
                                      ).textTheme.bodyMedium?.color ??
                                      Colors.black,
                                  BlendMode.srcIn,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "Weight",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color:
                                      Theme.of(
                                        context,
                                      ).textTheme.bodyMedium?.color,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).dividerColor,
                                width: 1.w,
                              ),
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Text(
                              "15.2 lbs",
                              style: TextStyle(
                                fontSize: 18.sp,
                                color:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.color,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Assets.svg.icons.weightIcon.svg(
                                width: 12.w,
                                height: 12.h,
                                colorFilter: ColorFilter.mode(
                                  Theme.of(
                                        context,
                                      ).textTheme.bodyMedium?.color ??
                                      Colors.black,
                                  BlendMode.srcIn,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "Weight",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color:
                                      Theme.of(
                                        context,
                                      ).textTheme.bodyMedium?.color,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).dividerColor,
                                width: 1.w,
                              ),
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Text(
                              "15.2 lbs",
                              style: TextStyle(
                                fontSize: 18.sp,
                                color:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.color,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Assets.svg.icons.weightIcon.svg(
                                width: 12.w,
                                height: 12.h,
                                colorFilter: ColorFilter.mode(
                                  Theme.of(
                                        context,
                                      ).textTheme.bodyMedium?.color ??
                                      Colors.black,
                                  BlendMode.srcIn,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "Weight",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color:
                                      Theme.of(
                                        context,
                                      ).textTheme.bodyMedium?.color,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).dividerColor,
                                width: 1.w,
                              ),
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Text(
                              "15.2 lbs",
                              style: TextStyle(
                                fontSize: 18.sp,
                                color:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.color,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  GenderPercentIndicator(
                    malePercent: 57.5,
                    femalePercent: 42.5,
                  ),
                  SizedBox(height: 40.h),
                  Text(
                    "Weakness",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  ElementChipsComponent(
                    elements: ["Fire", "Water", "Grass"],
                    size: ChipSize.grid,
                    useGrid: true,
                    chipSpacing: 16.w,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Evolution",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 24.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: Theme.of(context).dividerColor,
                        width: 1.w,
                      ),
                    ),
                    child: ListView.separated(
                      itemBuilder: (_, __) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90.r),
                            border: Border.all(
                              color: Theme.of(context).dividerColor,
                              width: 1.w,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(8.w),
                                  decoration: BoxDecoration(
                                    color: ElementColor.fireElement,
                                    borderRadius: BorderRadius.circular(90.r),
                                  ),
                                  child: Assets.images.dummies.charizard.image(
                                    height: 72.h,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Charizard",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    ElementChipsComponent(
                                      elements: ["Fire", "Flying"],
                                      size: ChipSize.simple,
                                      maxElementsToShow: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (_, __) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          child: Assets.svg.icons.arrowDownIcon.svg(
                            width: 18.w,
                          ),
                        );
                      },
                      itemCount: 3,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class GenderPercentIndicator extends StatelessWidget {
  final double malePercent;
  final double femalePercent;

  const GenderPercentIndicator({
    super.key,
    required this.malePercent,
    required this.femalePercent,
  });

  @override
  Widget build(BuildContext context) {
    assert(
      (malePercent + femalePercent).toStringAsFixed(1) == '100.0',
      'Total percentage must be 100%',
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("GENDER", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Row(
            children: [
              Expanded(
                flex: (malePercent * 10).round(),
                child: Container(height: 10, color: Colors.blue),
              ),
              Expanded(
                flex: (femalePercent * 10).round(),
                child: Container(height: 10, color: Colors.pinkAccent),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.male, size: 18),
                const SizedBox(width: 4),
                Text("${malePercent.toStringAsFixed(1).replaceAll('.', ',')}%"),
              ],
            ),
            Row(
              children: [
                Text(
                  "${femalePercent.toStringAsFixed(1).replaceAll('.', ',')}%",
                ),
                const SizedBox(width: 4),
                const Icon(Icons.female, size: 18),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
