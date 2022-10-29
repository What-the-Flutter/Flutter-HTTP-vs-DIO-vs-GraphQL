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
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:client/presentation/pages/auth/auth_page.dart' as _i1;
import 'package:client/presentation/pages/home/home_page.dart' as _i2;
import 'package:client/presentation/pages/post_detailed/post_detailed_page.dart'
    as _i3;
import 'package:flutter/material.dart' as _i5;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    AuthRouteWidget.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i1.AuthPageWidget(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomePage(),
      );
    },
    PostDetailedRoute.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i3.PostDetailedPage(),
      );
    },
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(
          AuthRouteWidget.name,
          path: '/',
        ),
        _i4.RouteConfig(
          HomeRoute.name,
          path: '/home',
        ),
        _i4.RouteConfig(
          PostDetailedRoute.name,
          path: '/post',
        ),
      ];
}

/// generated route for
/// [_i1.AuthPageWidget]
class AuthRouteWidget extends _i4.PageRouteInfo<void> {
  const AuthRouteWidget()
      : super(
          AuthRouteWidget.name,
          path: '/',
        );

  static const String name = 'AuthRouteWidget';
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/home',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i3.PostDetailedPage]
class PostDetailedRoute extends _i4.PageRouteInfo<void> {
  const PostDetailedRoute()
      : super(
          PostDetailedRoute.name,
          path: '/post',
        );

  static const String name = 'PostDetailedRoute';
}
