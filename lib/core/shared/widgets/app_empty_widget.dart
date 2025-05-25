import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rama_poke_app/core/assets/gen/assets.gen.dart';

class NoScrollGlowBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}

class AppEmptyWidget extends StatelessWidget {
  final String descText;
  final String titleText;
  final double? customHeightContent;
  final double heightImage;
  final double? widthImage;
  final TextStyle? customDescTextStyle;
  final TextStyle? customTitleTextStyle;
  final Function()? onRefresh;
  final String type;
  final bool isCentered;
  final bool removeTitle;

  /// jik ini null maka akan ada button yang muncul
  final Widget? additionalWidgetBellowTextDesc;

  const AppEmptyWidget({
    super.key,
    this.descText = 'Maaf, saat ini data kamu tidak tersedia',
    this.titleText = 'Data tidak tersedia',
    this.customDescTextStyle,
    this.customTitleTextStyle,
    this.customHeightContent,
    this.onRefresh,
    this.isCentered = true,
    this.additionalWidgetBellowTextDesc,
  }) : heightImage = 0,
       widthImage = 0,
       type = 'default',
       removeTitle = false;

  const AppEmptyWidget.custom({
    super.key,
    this.descText = 'Maaf, saat ini data kamu tidak tersedia',
    this.titleText = 'Data tidak tersedia',
    this.customDescTextStyle,
    this.customHeightContent,
    this.customTitleTextStyle,
    required this.heightImage,
    required this.widthImage,
    this.isCentered = true,
    this.onRefresh,
    this.additionalWidgetBellowTextDesc,
  }) : type = 'custom',
       removeTitle = false;

  const AppEmptyWidget.removeTitle({
    super.key,
    this.descText = 'Maaf, saat ini data kamu tidak tersedia',
    this.customDescTextStyle,
    this.customHeightContent,
    this.onRefresh,
    this.isCentered = true,
    this.additionalWidgetBellowTextDesc,
  }) : heightImage = 0,
       widthImage = 0,
       type = 'default',
       titleText = '',
       customTitleTextStyle = null,
       removeTitle = true;

  @override
  Widget build(BuildContext context) {
    return (onRefresh != null)
        ? RefreshIndicator(
          onRefresh: () async {
            onRefresh!();
          },
          child: ScrollConfiguration(
            behavior: NoScrollGlowBehavior(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: _content(context),
            ),
          ),
        )
        : _content(context);
  }

  Widget _content(BuildContext context) {
    return SizedBox(
      height: onRefresh == null ? null : customHeightContent ?? 1.sh / 1.4,
      child: Column(
        mainAxisAlignment:
            isCentered ? MainAxisAlignment.center : MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.lotties.pokemonLoadingAnimation.lottie(
            height: heightImage,
            width: widthImage,
          ),
          !removeTitle
              ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  titleText,
                  style:
                      customTitleTextStyle ??
                      TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                  textAlign: TextAlign.center,
                ),
              )
              : const SizedBox(),
          SizedBox(height: !removeTitle ? 6.h : 0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              descText,
              style:
                  customDescTextStyle ??
                  TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          additionalWidgetBellowTextDesc ?? const SizedBox(),
        ],
      ),
    );
  }
}
