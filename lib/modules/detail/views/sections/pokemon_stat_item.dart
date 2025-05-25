import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rama_poke_app/core/assets/gen/assets.gen.dart';

class PokemonStat {
  final String label;
  final String value;
  final SvgGenImage icon;

  PokemonStat({required this.label, required this.value, required this.icon});
}

class PokemonStatItem extends StatelessWidget {
  final PokemonStat stat;

  const PokemonStatItem({super.key, required this.stat});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            stat.icon.svg(
              width: 12.w,
              height: 12.h,
              colorFilter: ColorFilter.mode(
                Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              stat.label,
              style: TextStyle(
                fontSize: 12.sp,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).dividerColor,
              width: 1.w,
            ),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Text(
            stat.value,
            style: TextStyle(
              fontSize: 18.sp,
              color: Theme.of(context).textTheme.bodyMedium?.color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
