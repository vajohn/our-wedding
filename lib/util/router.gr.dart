// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i3;

import '../screens/screens.dart' as _i1;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i3.GlobalKey<_i3.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    HomeScreen.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.HomeScreen());
    },
    LoginScreen.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.LoginScreen());
    },
    SplitRsvp.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.SplitRsvp());
    }
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig(HomeScreen.name, path: '/'),
        _i2.RouteConfig(LoginScreen.name, path: '/login-screen'),
        _i2.RouteConfig(SplitRsvp.name, path: '/split-rsvp')
      ];
}

/// generated route for [_i1.HomeScreen]
class HomeScreen extends _i2.PageRouteInfo<void> {
  const HomeScreen() : super(name, path: '/');

  static const String name = 'HomeScreen';
}

/// generated route for [_i1.LoginScreen]
class LoginScreen extends _i2.PageRouteInfo<void> {
  const LoginScreen() : super(name, path: '/login-screen');

  static const String name = 'LoginScreen';
}

/// generated route for [_i1.SplitRsvp]
class SplitRsvp extends _i2.PageRouteInfo<void> {
  const SplitRsvp() : super(name, path: '/split-rsvp');

  static const String name = 'SplitRsvp';
}
