import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rama_poke_app/core/assets/element/element_color.dart';
import 'package:rama_poke_app/core/extensions/type_of_pokemon_extension.dart';
import 'package:rama_poke_app/modules/pokedex/controllers/pokedex_controller.dart';
import 'package:rama_poke_app/modules/pokedex/views/components/bottom_sheet_type_component.dart';

class ButtonTypeComponent extends StatelessWidget {
  const ButtonTypeComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PokedexController>(
      builder: (context, controller, child) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.r),
            ),
            backgroundColor:
                controller.selectedTypeController.selectedType != null
                    ? (controller.selectedTypeController.selectedType?.color ??
                        ElementColor.allTypeElement)
                    : ElementColor.allTypeElement,
            shadowColor: Colors.transparent,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          ),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(),
              builder: (context) {
                return BottomSheetTypeComponent(
                  initialSelected:
                      controller.selectedTypeController.selectedType,
                  onTypeSelected: (type) {
                    controller.setSelectedType(type);
                  },
                );
              },
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                controller.selectedTypeController.selectedType != null
                    ? (controller.selectedTypeController.selectedType?.name ??
                        "Type")
                    : "All Type",
                style: TextStyle(fontSize: 16.sp, color: Colors.white),
              ),
              SizedBox(width: 10.w),
              Icon(Icons.keyboard_arrow_down, size: 20.sp, color: Colors.white),
            ],
          ),
        );
      },
    );
  }
}
