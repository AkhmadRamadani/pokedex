import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

enum ShimmerShape { rectangle, circle }

class CustomShimmerWidget {
  static Widget buildShimmerWidget({
    double width = 100,
    double height = 100,
    double radius = 0,
    ShimmerShape shape = ShimmerShape.rectangle,
    Color? baseColor,
    Color? highlightColor,
    Duration period = const Duration(milliseconds: 1500),
    ShimmerDirection direction = ShimmerDirection.ltr,
    EdgeInsets? margin,
    EdgeInsets? padding,
  }) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Color(0xFFE0E0E0),
      highlightColor: highlightColor ?? Color(0xFFBDBDBD),
      direction: direction,
      period: period,
      child: Container(
        width: width,
        height: height,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: Colors.white,
          shape:
              shape == ShimmerShape.circle
                  ? BoxShape.circle
                  : BoxShape.rectangle,
          borderRadius:
              shape == ShimmerShape.rectangle
                  ? BorderRadius.circular(radius)
                  : null,
        ),
      ),
    );
  }

  Widget list({
    required int length,
    Axis direction = Axis.vertical,
    EdgeInsets itemSpacing = const EdgeInsets.only(bottom: 16),
    Duration shimmerPeriod = const Duration(milliseconds: 1500),
    ShimmerDirection shimmerDirection = ShimmerDirection.ltr,
    Color? baseColor,
    Color? highlightColor,
  }) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: direction,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          margin: itemSpacing,
          child:
              direction == Axis.vertical
                  ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildShimmerWidget(
                        width: 80,
                        height: 80,
                        radius: 16,
                        period: shimmerPeriod,
                        direction: shimmerDirection,
                        baseColor: baseColor,
                        highlightColor: highlightColor,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildShimmerWidget(
                              width: double.infinity,
                              height: 16,
                              radius: 8,
                              period: shimmerPeriod,
                              direction: shimmerDirection,
                              baseColor: baseColor,
                              highlightColor: highlightColor,
                            ),
                            const SizedBox(height: 8),
                            buildShimmerWidget(
                              width: double.infinity,
                              height: 16,
                              radius: 8,
                              period: shimmerPeriod,
                              direction: shimmerDirection,
                              baseColor: baseColor,
                              highlightColor: highlightColor,
                            ),
                            const SizedBox(height: 8),
                            buildShimmerWidget(
                              width: 100,
                              height: 16,
                              radius: 8,
                              period: shimmerPeriod,
                              direction: shimmerDirection,
                              baseColor: baseColor,
                              highlightColor: highlightColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                  : Column(
                    children: [
                      buildShimmerWidget(
                        width: 80,
                        height: 80,
                        radius: 16,
                        period: shimmerPeriod,
                        direction: shimmerDirection,
                        baseColor: baseColor,
                        highlightColor: highlightColor,
                      ),
                      const SizedBox(height: 8),
                      buildShimmerWidget(
                        width: 100,
                        height: 16,
                        radius: 8,
                        period: shimmerPeriod,
                        direction: shimmerDirection,
                        baseColor: baseColor,
                        highlightColor: highlightColor,
                      ),
                    ],
                  ),
        );
      },
      itemCount: length,
    );
  }
}
