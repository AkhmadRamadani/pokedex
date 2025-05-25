// Alternative: Enhanced favorite button with better animations
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rama_poke_app/core/assets/gen/assets.gen.dart';
import 'package:rama_poke_app/core/shared/models/pokemon_model.dart';

class EnhancedFavoriteButton extends StatefulWidget {
  const EnhancedFavoriteButton({
    super.key,
    required this.pokemon,
    required this.onToggle,
    required this.isLoading,
  });

  final PokemonEntityModel pokemon;
  final VoidCallback onToggle;
  final bool isLoading;

  @override
  State<EnhancedFavoriteButton> createState() => _EnhancedFavoriteButtonState();
}

class _EnhancedFavoriteButtonState extends State<EnhancedFavoriteButton>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _bounceController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    _bounceAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.elasticOut),
    );
  }

  @override
  void didUpdateWidget(EnhancedFavoriteButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Trigger bounce animation when favorite status changes
    if (oldWidget.pokemon.isFavorite != widget.pokemon.isFavorite &&
        widget.pokemon.isFavorite == true) {
      _bounceController.forward().then((_) {
        _bounceController.reverse();
      });
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (widget.isLoading) return;

    _scaleController.forward().then((_) {
      _scaleController.reverse();
    });

    widget.onToggle();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        padding: EdgeInsets.all(8.w),
        child: AnimatedBuilder(
          animation: Listenable.merge([_scaleController, _bounceController]),
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value * _bounceAnimation.value,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child:
                    widget.isLoading
                        ? SizedBox(
                          key: const ValueKey('loading'),
                          width: 32.w,
                          height: 32.h,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor,
                            ),
                          ),
                        )
                        : widget.pokemon.isFavorite == true
                        ? Assets.svg.icons.favoriteCardActiveIcon.svg(
                          key: const ValueKey('active'),
                          width: 32.w,
                          height: 32.h,
                        )
                        : Assets.svg.icons.favoriteCardInactiveIcon.svg(
                          key: const ValueKey('inactive'),
                          width: 32.w,
                          height: 32.h,
                        ),
              ),
            );
          },
        ),
      ),
    );
  }
}
