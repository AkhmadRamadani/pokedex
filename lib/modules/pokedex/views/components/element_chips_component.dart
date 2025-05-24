import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rama_poke_app/core/assets/element/element_asset.dart';
import 'package:rama_poke_app/core/assets/element/element_color.dart';

class ElementChipsComponent extends StatelessWidget {
  final List<String> elements;
  final double chipSpacing;
  final ChipSize size;
  final int? maxElementsToShow;
  final bool useGrid;

  const ElementChipsComponent({
    super.key,
    required this.elements,
    this.chipSpacing = 4.0,
    this.size = ChipSize.medium,
    this.maxElementsToShow,
    this.useGrid = false,
  });

  List<String> _getDisplayedElements() {
    if (maxElementsToShow != null && elements.length > maxElementsToShow!) {
      final shown = elements.sublist(0, maxElementsToShow!);
      final moreCount = elements.length - maxElementsToShow!;
      return [...shown, '+$moreCount more'];
    }
    return elements;
  }

  @override
  Widget build(BuildContext context) {
    if (elements.isEmpty) return const SizedBox.shrink();

    final displayedElements = _getDisplayedElements();
    final children =
        displayedElements.map((element) {
          final chipSize = useGrid ? ChipSize.grid : size;

          if (element.startsWith('+')) {
            return MoreChip(text: element, size: chipSize);
          }

          return ElementChip(
            element: element,
            size: chipSize,
            isInGrid: useGrid,
          );
        }).toList();

    if (useGrid) {
      return GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        crossAxisCount: 2,
        mainAxisSpacing: chipSpacing,
        crossAxisSpacing: chipSpacing,
        childAspectRatio: 4,
        children: children,
      );
    }

    return Wrap(
      spacing: chipSpacing,
      runSpacing: chipSpacing,
      children: children,
    );
  }
}

class ElementChip extends StatelessWidget {
  final String element;
  final ChipSize size;
  final bool isInGrid;

  const ElementChip({
    super.key,
    required this.element,
    required this.size,
    this.isInGrid = false,
  });

  @override
  Widget build(BuildContext context) {
    final double paddingVertical =
        size == ChipSize.small
            ? 1.h
            : size == ChipSize.medium
            ? 2.h
            : size == ChipSize.big
            ? 4.h
            : size == ChipSize.grid
            ? 4.h
            : 2.h;

    final double paddingHorizontal =
        size == ChipSize.small
            ? 0.w
            : size == ChipSize.medium
            ? 0.w
            : size == ChipSize.big
            ? 4.w
            : size == ChipSize.grid
            ? 4.w
            : 0.w;

    final double iconSize =
        size == ChipSize.small
            ? 12.w
            : size == ChipSize.medium
            ? 16.w
            : size == ChipSize.big
            ? 18.w
            : size == ChipSize.grid
            ? 18.w
            : 16.w;

    final double iconContainerSize =
        size == ChipSize.small
            ? 16.w
            : size == ChipSize.medium
            ? 20.w
            : size == ChipSize.big
            ? 24.w
            : size == ChipSize.grid
            ? 28.w
            : 20.w;

    final double textSize =
        size == ChipSize.small
            ? 10.sp
            : size == ChipSize.medium
            ? 12.sp
            : size == ChipSize.big
            ? 14.sp
            : size == ChipSize.grid
            ? 14.sp
            : 12.sp;

    final double spacing =
        size == ChipSize.small
            ? 2.w
            : size == ChipSize.medium
            ? 4.w
            : size == ChipSize.big
            ? 8.w
            : size == ChipSize.grid
            ? 8.w
            : 4.w;

    final simpleWidget = Container(
      width: 68.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.r),
        color: ElementColor.fireElement,
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
      child: ElementAsset.fire(width: 10.w, height: 10.w, color: Colors.white),
    );

    final chipWidget = Chip(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.r),
        side: BorderSide.none,
      ),
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      side: BorderSide.none,
      padding: EdgeInsets.symmetric(
        vertical: paddingVertical,
        horizontal: paddingHorizontal,
      ),
      backgroundColor: ElementColor.fireElement,
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: iconContainerSize,
            height: iconContainerSize,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: SizedBox(
              width: iconSize,
              height: iconSize,
              child: ElementAsset.fire(width: iconSize, height: iconSize),
            ),
          ),
          SizedBox(width: spacing),
          Text(
            element,
            style: TextStyle(
              fontSize: textSize,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );

    final gridWidget = Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.r),
        color: ElementColor.fireElement,
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: iconContainerSize,
            height: iconContainerSize,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: SizedBox(
              width: iconSize,
              height: iconSize,
              child: ElementAsset.fire(width: iconSize, height: iconSize),
            ),
          ),
          SizedBox(width: spacing),
          Text(
            element,
            style: TextStyle(
              fontSize: textSize,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );

    return isInGrid
        ? gridWidget
        : size == ChipSize.simple
        ? simpleWidget
        : chipWidget;
  }
}

class MoreChip extends StatelessWidget {
  final String text;
  final ChipSize size;

  const MoreChip({super.key, required this.text, required this.size});

  @override
  Widget build(BuildContext context) {
    final double paddingVertical =
        size == ChipSize.small
            ? 1.h
            : size == ChipSize.medium
            ? 2.h
            : size == ChipSize.big
            ? 4.h
            : size == ChipSize.grid
            ? 6.h
            : 2.h;

    final double textSize =
        size == ChipSize.small
            ? 10.sp
            : size == ChipSize.medium
            ? 12.sp
            : size == ChipSize.big
            ? 14.sp
            : size == ChipSize.grid
            ? 16.sp
            : 12.sp;

    return Chip(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.r),
        side: BorderSide.none,
      ),
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      side: BorderSide.none,
      padding: EdgeInsets.symmetric(vertical: paddingVertical),
      backgroundColor: Colors.grey[300],
      label: Text(
        text,
        style: TextStyle(
          fontSize: textSize,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

enum ChipSize { small, medium, big, simple, grid }
