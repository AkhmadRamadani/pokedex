import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rama_poke_app/modules/detail/controllers/detail_controller.dart';
import 'package:rama_poke_app/modules/detail/views/components/collapsed_app_bar_component.dart';

class DetailAppBarSection extends StatelessWidget {
  final ScrollController scrollController;

  const DetailAppBarSection({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailController>(
      builder: (context, controller, child) {
        return DetailStateHandler(
          pokemonState: controller.pokemonState,
          onLoading:
              () => const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              ),
          onSuccess:
              (pokemon) => CollapsingAppBar(
                scrollController: scrollController,
                pokemon: pokemon,
              ),
          onError: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
        );
      },
    );
  }
}

class DetailStateHandler extends StatelessWidget {
  final dynamic pokemonState;
  final Widget Function() onLoading;
  final Widget Function(dynamic pokemon) onSuccess;
  final Widget Function() onError;

  const DetailStateHandler({
    super.key,
    required this.pokemonState,
    required this.onLoading,
    required this.onSuccess,
    required this.onError,
  });

  @override
  Widget build(BuildContext context) {
    if (pokemonState.isLoading()) {
      return onLoading();
    }

    if (pokemonState.isSuccess()) {
      final dataSuccess = pokemonState.dataSuccess();
      if (dataSuccess != null) {
        return onSuccess(dataSuccess);
      }
    }

    return onError();
  }
}
