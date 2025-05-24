import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rama_poke_app/core/assets/gen/assets.gen.dart';

class AppSearchAppBarWidget extends StatefulWidget
    implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onLeadingPressed;
  final Color? borderColor;
  final Color? titleColor;
  final Widget? leadingIcon;
  final void Function(String)? onSearch;

  const AppSearchAppBarWidget({
    super.key,
    required this.title,
    this.onLeadingPressed,
    this.borderColor,
    this.titleColor,
    this.leadingIcon,
    this.onSearch,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 22);

  @override
  State<AppSearchAppBarWidget> createState() => _AppSearchAppBarWidgetState();
}

class _AppSearchAppBarWidgetState extends State<AppSearchAppBarWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: TextFormField(
            controller: _searchController,
            onChanged: widget.onSearch,
            style: TextStyle(
              color:
                  widget.titleColor ??
                  Theme.of(context).textTheme.bodyMedium?.color,
              fontSize: 14.sp,
            ),
            decoration: InputDecoration(
              hintText: widget.title,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.r),
                borderSide: BorderSide(
                  color:
                      widget.borderColor ??
                      Theme.of(
                        context,
                      ).inputDecorationTheme.focusedBorder?.borderSide.color ??
                      Theme.of(context).dividerColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.r),
                borderSide: BorderSide(
                  color:
                      widget.borderColor ??
                      Theme.of(
                        context,
                      ).inputDecorationTheme.focusedBorder?.borderSide.color ??
                      Theme.of(context).dividerColor,
                ),
              ),
              hintStyle: TextStyle(
                color: widget.titleColor ?? Theme.of(context).hintColor,
                fontSize: 14.sp,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.r),
                borderSide: BorderSide(
                  color:
                      widget.borderColor ??
                      Theme.of(
                        context,
                      ).inputDecorationTheme.focusedBorder?.borderSide.color ??
                      Theme.of(context).dividerColor,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 12.h,
                horizontal: 16.w,
              ),
              prefixIcon:
                  widget.leadingIcon ??
                  Assets.svg.icons.searchIcon.svg(
                    colorFilter: ColorFilter.mode(
                      widget.titleColor ?? Theme.of(context).hintColor,
                      BlendMode.srcIn,
                    ),
                    width: 20.w,
                    height: 20.w,
                    fit: BoxFit.scaleDown,
                  ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Divider(
          color: widget.borderColor ?? Theme.of(context).dividerColor,
          height: 1,
        ),
      ],
    );
  }
}
