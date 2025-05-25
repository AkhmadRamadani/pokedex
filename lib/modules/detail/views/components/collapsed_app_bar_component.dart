import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rama_poke_app/core/shared/models/pokemon_model.dart';
import 'package:rama_poke_app/core/shared/widgets/app_image_network_widget.dart';
import 'package:rama_poke_app/modules/detail/views/clipper/custom_curve_clipper.dart';

class CollapsingAppBar extends StatefulWidget {
  final ScrollController scrollController;
  final PokemonEntityModel pokemon;

  const CollapsingAppBar({
    super.key,
    required this.scrollController,
    required this.pokemon,
  });

  @override
  State<CollapsingAppBar> createState() => _CollapsingAppBarState();
}

class _CollapsingAppBarState extends State<CollapsingAppBar>
    with SingleTickerProviderStateMixin {
  bool _isCollapsed = false;
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _sizeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    widget.scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    bool isNowCollapsed =
        widget.scrollController.offset > (300.h - kToolbarHeight - 120.h);
    if (isNowCollapsed != _isCollapsed) {
      setState(() {
        _isCollapsed = isNowCollapsed;
      });
      if (_isCollapsed) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    widget.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300.h,
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor: widget.pokemon.color,
      collapsedHeight: 60.h,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 24.w,
            color: Colors.white,
          ),
          Icon(Icons.favorite_border_rounded, size: 24.w, color: Colors.white),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(60.h * (1 - _sizeAnimation.value)),
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            final sizeValue = (1 - _sizeAnimation.value).clamp(0.0, 1.0);
            return SizedBox(
              width: 160.w * (sizeValue),
              height: 160.w * (sizeValue),
              child: Opacity(
                opacity: (1 - _opacityAnimation.value).clamp(0.0, 1.0),
                child:
                    sizeValue > 0.1
                        ? AppImageNetworkWidget(
                          imageUrl: widget.pokemon.imageurl ?? "",
                          width: 160.w * sizeValue,
                          height: 100.h * sizeValue,
                          fit: BoxFit.cover,
                        )
                        : const SizedBox.shrink(),
              ),
            );
          },
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: ClipPath(
            clipper: CustomCurveClipper(),
            clipBehavior: Clip.antiAlias,
            child: Container(height: 300.h, color: widget.pokemon.color),
          ),
        ),
        titlePadding: EdgeInsets.only(right: 16.w, top: 16.h),
        title: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Opacity(
              opacity: _opacityAnimation.value.clamp(0.0, 1.0),
              child: Transform.translate(
                offset: Offset(0, 20 * (1 - _opacityAnimation.value)),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.w),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width - 120.w,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (_opacityAnimation.value > 0.1)
                            AppImageNetworkWidget(
                              imageUrl: widget.pokemon.imageurl ?? "",
                              fit: BoxFit.cover,
                              width: 80.w,
                              height: 80.w,
                            ),
                          SizedBox(width: 12.w),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.pokemon.name ?? "Pokemon",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                widget.pokemon.id ?? "#000",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
