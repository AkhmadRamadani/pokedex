import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional/flutter_conditional.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rama_poke_app/core/assets/gen/assets.gen.dart';
import 'package:rama_poke_app/core/shared/models/pokemon_model.dart';
import 'package:rama_poke_app/core/shared/widgets/app_image_network_widget.dart';
import 'package:rama_poke_app/modules/detail/controllers/detail_controller.dart';
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
  static const Duration _animationDuration = Duration(milliseconds: 300);
  static const double _expandedHeight = 300.0;
  static const double _collapsedHeight = 60.0;
  static const double _imageSize = 160.0;
  static const double _collapsedImageSize = 80.0;
  static const double _collapsedImageSpacing = 12.0;
  static const double _titleFontSize = 20.0;
  static const double _iconSize = 24.0;
  static const double _titleOffset = 20.0;
  static const double _visibilityThreshold = 0.1;

  bool _isCollapsed = false;
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    widget.scrollController.addListener(_scrollListener);
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );

    final curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(curvedAnimation);
    _sizeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(curvedAnimation);
  }

  void _scrollListener() {
    final collapseThreshold = _expandedHeight.h - kToolbarHeight - 120.h;
    final isNowCollapsed = widget.scrollController.offset > collapseThreshold;

    if (isNowCollapsed != _isCollapsed) {
      setState(() {
        _isCollapsed = isNowCollapsed;
      });
      _updateAnimation();
    }
  }

  void _updateAnimation() {
    if (_isCollapsed) {
      _animationController.forward();
    } else {
      _animationController.reverse();
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
      expandedHeight: _expandedHeight.h,
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor: widget.pokemon.color,
      collapsedHeight: _collapsedHeight.h,
      title: _buildAppBarTitle(),
      bottom: _buildAnimatedImageBottom(),
      flexibleSpace: _buildFlexibleSpace(),
    );
  }

  Widget _buildAppBarTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_buildBackButton(), _buildFavoriteButton()],
    );
  }

  Widget _buildBackButton() {
    return GestureDetector(
      onTap: () => context.pop(),
      child: Icon(
        Icons.arrow_back_ios_new_rounded,
        size: _iconSize.w,
        color: Colors.white,
      ),
    );
  }

  Widget _buildFavoriteButton() {
    return Consumer<DetailController>(
      builder: (context, controller, child) {
        return GestureDetector(
          onTap: () => controller.toggleFavorite(context, widget.pokemon),
          child: _buildFavoriteIcon(controller),
        );
      },
    );
  }

  Widget _buildFavoriteIcon(DetailController controller) {
    final isFavorite =
        controller.pokemonState.dataSuccess()?.isFavorite == true;

    return Conditional.single(
      condition: isFavorite,
      widget: Assets.svg.icons.favoriteDetailActiveIcon.svg(
        width: _iconSize.w,
        height: _iconSize.w,
      ),
      fallback: Assets.svg.icons.favoriteDetailInactiveIcon.svg(
        width: _iconSize.w,
        height: _iconSize.h,
      ),
    );
  }

  PreferredSize _buildAnimatedImageBottom() {
    return PreferredSize(
      preferredSize: Size.fromHeight(
        _collapsedHeight.h * (1 - _sizeAnimation.value),
      ),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) => _buildAnimatedImage(),
      ),
    );
  }

  Widget _buildAnimatedImage() {
    final sizeValue = (1 - _sizeAnimation.value).clamp(0.0, 1.0);
    final imageSize = _imageSize.w * sizeValue;

    return SizedBox(
      width: imageSize,
      height: imageSize,
      child: Opacity(
        opacity: (1 - _opacityAnimation.value).clamp(0.0, 1.0),
        child:
            sizeValue > _visibilityThreshold
                ? _buildNetworkImage(imageSize, 100.h * sizeValue)
                : const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildNetworkImage(double width, double height) {
    return AppImageNetworkWidget(
      imageUrl: widget.pokemon.imageurl ?? "",
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }

  Widget _buildFlexibleSpace() {
    return FlexibleSpaceBar(
      background: _buildBackground(),
      titlePadding: EdgeInsets.only(right: 16.w, top: 16.h),
      title: _buildAnimatedTitle(),
    );
  }

  Widget _buildBackground() {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ClipPath(
        clipper: CustomCurveClipper(),
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: _expandedHeight.h,
          color: widget.pokemon.color,
        ),
      ),
    );
  }

  Widget _buildAnimatedTitle() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => _buildTitleContent(),
    );
  }

  Widget _buildTitleContent() {
    return Opacity(
      opacity: _opacityAnimation.value.clamp(0.0, 1.0),
      child: Transform.translate(
        offset: Offset(0, _titleOffset * (1 - _opacityAnimation.value)),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: _buildTitleRow(),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleRow() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width - 120.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (_opacityAnimation.value > _visibilityThreshold)
            _buildCollapsedImage(),
          SizedBox(width: _collapsedImageSpacing.w),
          _buildTitleText(),
        ],
      ),
    );
  }

  Widget _buildCollapsedImage() {
    return AppImageNetworkWidget(
      imageUrl: widget.pokemon.imageurl ?? "",
      fit: BoxFit.cover,
      width: _collapsedImageSize.w,
      height: _collapsedImageSize.w,
    );
  }

  Widget _buildTitleText() {
    return Text(
      widget.pokemon.name ?? "Pokemon",
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Colors.white,
        fontSize: _titleFontSize.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
