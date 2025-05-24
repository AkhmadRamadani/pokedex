import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rama_poke_app/core/assets/gen/assets.gen.dart';
import 'package:rama_poke_app/core/config/route_config.gr.dart';

@RoutePage()
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(child: Lottie.asset(Assets.lotties.loadingAnimation.path)),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        navigateToHome(context);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void navigateToHome(BuildContext context) {
    context.router.replaceAll([const HomeRoute()]);
  }
}
