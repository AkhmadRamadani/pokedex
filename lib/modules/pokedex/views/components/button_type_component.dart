import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rama_poke_app/core/assets/element/element_color.dart';

class ButtonTypeComponent extends StatelessWidget {
  const ButtonTypeComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.r),
        ),
        backgroundColor: ElementColor.allTypeElement,
        shadowColor: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      ),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "All Type",
            style: TextStyle(fontSize: 16.sp, color: Colors.white),
          ),
          SizedBox(width: 10.w),
          Icon(Icons.keyboard_arrow_down, size: 20.sp, color: Colors.white),
        ],
      ),
    );
  }
}
