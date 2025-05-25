import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rama_poke_app/core/extensions/color_extension.dart';
import 'package:rama_poke_app/core/extensions/type_of_pokemon_extension.dart';
import 'package:rama_poke_app/core/shared/models/pokemon_model.dart';

enum ChipSize { small, medium, big, simple, grid }

class ElementChipsComponent extends StatelessWidget {
  final List<TypeOfPokemon> elements;
  final double chipSpacing;
  final ChipSize size;
  final int? maxElementsToShow;
  final bool useGrid;
  final bool clipText;
  final void Function(TypeOfPokemon)? onSelected;
  final Set<TypeOfPokemon>? selectedElements;
  final bool allowMultipleSelection; // New parameter

  const ElementChipsComponent({
    super.key,
    required this.elements,
    this.chipSpacing = 4.0,
    this.size = ChipSize.medium,
    this.maxElementsToShow,
    this.useGrid = false,
    this.clipText = false,
    this.onSelected,
    this.selectedElements,
    this.allowMultipleSelection = false, // Default to single selection
  });

  List<dynamic> _getDisplayedElements() {
    if (maxElementsToShow != null && elements.length > (maxElementsToShow!)) {
      final shown = elements.sublist(0, maxElementsToShow! - 1);
      final moreCount = elements.length - shown.length;
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

          if (element is String) {
            if (element.startsWith('+')) {
              return MoreChip(text: element, size: chipSize);
            }
          }

          bool isSelected = true;
          if (onSelected != null && selectedElements != null) {
            isSelected = selectedElements?.contains(element) ?? false;
          }

          return ElementChip(
            element: element,
            size: chipSize,
            isInGrid: useGrid,
            clippedText: clipText,
            isSelected: isSelected,
            onTap: onSelected != null ? () => onSelected!(element) : null,
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
  final TypeOfPokemon element;
  final ChipSize size;
  final bool isInGrid;
  final bool clippedText;
  final bool isSelected;
  final VoidCallback? onTap;

  const ElementChip({
    super.key,
    required this.element,
    required this.size,
    this.isInGrid = false,
    this.clippedText = false,
    this.isSelected = false,
    this.onTap,
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

    final backgroundColor =
        isSelected ? element.color : element.color.withAlphaFromOpacity(0.2);

    final borderColor = isSelected ? Colors.transparent : element.color;

    final textColor =
        isSelected
            ? (element.color.isColorDark ? Colors.white : Colors.black)
            : element.color;

    final simpleWidget = GestureDetector(
      onTap: onTap,
      child: Container(
        width: 68.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          color: backgroundColor,
          border: Border.all(color: borderColor, width: isSelected ? 0 : 2),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
        child: element.icon(
          10.w,
          10.w,
          isSelected ? Colors.white : element.color,
        ),
      ),
    );

    final chipWidget = GestureDetector(
      onTap: onTap,
      child: Chip(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.r),
          side: BorderSide(color: borderColor, width: isSelected ? 0 : 2),
        ),
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        padding: EdgeInsets.symmetric(
          vertical: paddingVertical,
          horizontal: paddingHorizontal,
        ),
        backgroundColor: backgroundColor,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: iconContainerSize,
              height: iconContainerSize,
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? Colors.white
                        : element.color.withAlphaFromOpacity(0.2),
                shape: BoxShape.circle,
                border:
                    isSelected
                        ? null
                        : Border.all(color: element.color, width: 1),
              ),
              alignment: Alignment.center,
              child: SizedBox(
                width: iconSize,
                height: iconSize,
                child: element.icon(iconSize, iconSize, null),
              ),
            ),
            SizedBox(width: spacing),
            Text(
              clippedText
                  ? element.name.length > 6
                      ? '${element.name.substring(0, 6)}...'
                      : element.name
                  : element.name,
              maxLines: 1,
              style: TextStyle(
                fontSize: textSize,
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );

    final gridWidget = GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          color: backgroundColor,
          border: Border.all(color: borderColor, width: isSelected ? 0 : 2),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: iconContainerSize,
              height: iconContainerSize,
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? Colors.white
                        : element.color.withAlphaFromOpacity(0.2),
                shape: BoxShape.circle,
                border:
                    isSelected
                        ? null
                        : Border.all(color: element.color, width: 1),
              ),
              alignment: Alignment.center,
              child: SizedBox(
                width: iconSize,
                height: iconSize,
                child: element.icon(iconSize, iconSize, null),
              ),
            ),
            SizedBox(width: spacing),
            Text(
              element.name,
              style: TextStyle(
                fontSize: textSize,
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
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
