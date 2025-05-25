import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional/flutter_conditional.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final Color? borderColor;
  final Color? titleColor;
  final Widget? leadingIcon;

  const CustomAppBarWidget({
    super.key,
    required this.title,
    this.borderColor,
    this.titleColor,
    this.leadingIcon,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 13);

  @override
  State<CustomAppBarWidget> createState() => _CustomAppBarWidgetState();
}

class _CustomAppBarWidgetState extends State<CustomAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          actions: [
            Conditional.single(
              condition:
                  AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark,
              widget: IconButton(
                icon: Icon(
                  Icons.light_mode,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
                onPressed: () {
                  AdaptiveTheme.of(context).toggleThemeMode(useSystem: false);
                },
              ),
              fallback: IconButton(
                icon: Icon(
                  Icons.dark_mode,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
                onPressed: () {
                  AdaptiveTheme.of(context).toggleThemeMode(useSystem: false);
                },
              ),
            ),
          ],
          title: Text(
            widget.title,
            style: TextStyle(
              color:
                  widget.titleColor ??
                  Theme.of(context).textTheme.bodyMedium?.color,
              fontSize: 18.sp,
            ),
          ),
          elevation: 0,
        ),
        const SizedBox(height: 12),
        Divider(
          color: widget.borderColor ?? Theme.of(context).dividerColor,
          height: 1,
        ),
      ],
    );
  }
}
