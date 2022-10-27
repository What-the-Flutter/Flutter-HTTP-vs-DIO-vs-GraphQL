// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:client/presentation/pages/auth/auth_page.dart' as _i1;
import 'package:client/presentation/pages/home/home_page.dart' as _i2;
import 'package:flutter/material.dart' as _i4;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    AuthRouteWidget.name: (routeData) {
      return _i3.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i1.AuthPageWidget(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i3.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomePage(),
      );
    },
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(
          AuthRouteWidget.name,
          path: '/',
        ),
        _i3.RouteConfig(
          HomeRoute.name,
          path: '/home',
        ),
      ];
}

/// generated route for
/// [_i1.AuthPageWidget]
class AuthRouteWidget extends _i3.PageRouteInfo<void> {
  const AuthRouteWidget()
      : super(
          AuthRouteWidget.name,
          path: '/',
        );

  static const String name = 'AuthRouteWidget';
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i3.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/home',
        );

  static const String name = 'HomeRoute';
}
