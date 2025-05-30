// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;
import 'package:rama_poke_app/modules/detail/views/detail_wrapper_page.dart'
    as _i1;
import 'package:rama_poke_app/modules/home/views/home_view.dart' as _i2;
import 'package:rama_poke_app/modules/splash/views/splash_view.dart' as _i3;

/// generated route for
/// [_i1.DetailWrapperPage]
class DetailWrapperRoute extends _i4.PageRouteInfo<DetailWrapperRouteArgs> {
  DetailWrapperRoute({
    _i5.Key? key,
    required String id,
    List<_i4.PageRouteInfo>? children,
  }) : super(
         DetailWrapperRoute.name,
         args: DetailWrapperRouteArgs(key: key, id: id),
         rawPathParams: {'id': id},
         initialChildren: children,
       );

  static const String name = 'DetailWrapperRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<DetailWrapperRouteArgs>(
        orElse: () => DetailWrapperRouteArgs(id: pathParams.getString('id')),
      );
      return _i1.DetailWrapperPage(key: args.key, id: args.id);
    },
  );
}

class DetailWrapperRouteArgs {
  const DetailWrapperRouteArgs({this.key, required this.id});

  final _i5.Key? key;

  final String id;

  @override
  String toString() {
    return 'DetailWrapperRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i2.HomeView]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute({List<_i4.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomeView();
    },
  );
}

/// generated route for
/// [_i3.SplashView]
class SplashRoute extends _i4.PageRouteInfo<void> {
  const SplashRoute({List<_i4.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.SplashView();
    },
  );
}
