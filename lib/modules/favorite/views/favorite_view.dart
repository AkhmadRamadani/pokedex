import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rama_poke_app/core/config/route_config.gr.dart';
import 'package:rama_poke_app/core/shared/widgets/app_empty_widget.dart';
import 'package:rama_poke_app/core/shared/widgets/app_shimmer_widget.dart';
import 'package:rama_poke_app/core/shared/widgets/custom_app_bar_widget.dart';
import 'package:rama_poke_app/modules/favorite/controllers/favorite_controller.dart';
import 'package:rama_poke_app/modules/pokedex/views/components/pokemon_card_component.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  static const String _appBarTitle = "Favorite";
  static const String _noDataTitle = "No favorite pokemon yet";
  static const String _noDataMessage =
      "Add your favorite pokemon by clicking the heart icon <3";
  static const String _defaultErrorTitle = "Woops! But don't worry";
  static const String _defaultErrorMessage = "There has been an error";
  static const double _horizontalPadding = 16.0;
  static const double _itemSpacing = 12.0;
  static const int _shimmerLength = 10;

  @override
  void initState() {
    super.initState();
    _initializeFavorites();
  }

  void _initializeFavorites() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = context.read<FavoriteController>();
      controller.getFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: _appBarTitle),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: _horizontalPadding.w),
        child: Consumer<FavoriteController>(
          builder: (context, controller, child) => _buildBody(controller),
        ),
      ),
    );
  }

  Widget _buildBody(FavoriteController controller) {
    final state = controller.favoriteState;

    if (state.isLoading()) {
      return _buildLoadingState();
    }

    if (state.isSuccess()) {
      return _buildSuccessState(controller, state.dataSuccess() ?? []);
    }

    if (state.isError()) {
      return _buildErrorState(controller);
    }

    if (state.isEmpty()) {
      return _buildEmptyState();
    }

    return const SizedBox.shrink();
  }

  Widget _buildLoadingState() {
    return CustomShimmerWidget().list(length: _shimmerLength);
  }

  Widget _buildSuccessState(
    FavoriteController controller,
    List<dynamic> pokemons,
  ) {
    if (pokemons.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.separated(
      itemBuilder:
          (context, index) => _buildPokemonCard(controller, pokemons[index]),
      separatorBuilder: (context, index) => SizedBox(height: _itemSpacing.h),
      itemCount: pokemons.length,
    );
  }

  Widget _buildPokemonCard(FavoriteController controller, dynamic pokemon) {
    return PokemonCardComponent(
      pokemon: pokemon,
      onTap: () => _navigateToDetail(pokemon),
      onFavoriteToggle: (pokemon) => _handleFavoriteToggle(controller, pokemon),
    );
  }

  void _navigateToDetail(dynamic pokemon) {
    context.pushRoute(DetailWrapperRoute(id: pokemon.id ?? ""));
  }

  void _handleFavoriteToggle(FavoriteController controller, dynamic pokemon) {
    controller.toggleFavorite(
      context,
      pokemon.id ?? "",
      pokemon.isFavorite ?? false,
    );
  }

  Widget _buildErrorState(FavoriteController controller) {
    final errorMessage =
        controller.favoriteState.messageError() ?? _defaultErrorMessage;
    return Center(
      child: AppEmptyWidget.custom(
        heightImage: 100.h,
        widthImage: 100.w,
        titleText: _defaultErrorTitle,
        descText: errorMessage,
        onRefresh: () {
          _initializeFavorites();
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: AppEmptyWidget.custom(
        titleText: _noDataTitle,
        descText: _noDataMessage,
        heightImage: 100.h,
        widthImage: 100.w,
        onRefresh: () {
          _initializeFavorites();
        },
      ),
    );
  }
}
