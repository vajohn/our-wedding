// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i3;

import '../screens/screens.dart' as _i1;
import 'router.dart' as _i4;

class AppRouter extends _i2.RootStackRouter {
  AppRouter(
      {_i3.GlobalKey<_i3.NavigatorState>? navigatorKey,
      required this.authGuard})
      : super(navigatorKey);

  final _i4.AuthGuard authGuard;

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    HomeScreen.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.HomeScreen());
    },
    LoginRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.LoginScreen());
    },
    SplitRsvp.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.SplitRsvp());
    },
    DynamicRegistrationRouter.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.DynamicRegistration());
    },
    DashboardRouter.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.Dashboard());
    },
    AdminDashboardRouter.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.AdminDashboard());
    },
    MainMenu.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.MainMenu());
    },
    StarterMenu.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.StarterMenu());
    },
    PendingGuests.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.PendingGuests());
    },
    ReservedGuests.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.ReservedGuests());
    }
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig(HomeScreen.name, path: '/'),
        _i2.RouteConfig(LoginRoute.name, path: 'login'),
        _i2.RouteConfig(SplitRsvp.name, path: '/split-rsvp'),
        _i2.RouteConfig(DynamicRegistrationRouter.name, path: 'registration'),
        _i2.RouteConfig(DashboardRouter.name, path: 'dashboard'),
        _i2.RouteConfig(AdminDashboardRouter.name, path: 'admin', guards: [
          authGuard
        ], children: [
          _i2.RouteConfig('#redirect',
              path: '',
              parent: AdminDashboardRouter.name,
              redirectTo: 'main',
              fullMatch: true),
          _i2.RouteConfig(MainMenu.name,
              path: 'main', parent: AdminDashboardRouter.name),
          _i2.RouteConfig(StarterMenu.name,
              path: 'starter', parent: AdminDashboardRouter.name),
          _i2.RouteConfig(PendingGuests.name,
              path: 'guests', parent: AdminDashboardRouter.name),
          _i2.RouteConfig(ReservedGuests.name,
              path: 'reserved', parent: AdminDashboardRouter.name)
        ])
      ];
}

/// generated route for
/// [_i1.HomeScreen]
class HomeScreen extends _i2.PageRouteInfo<void> {
  const HomeScreen() : super(HomeScreen.name, path: '/');

  static const String name = 'HomeScreen';
}

/// generated route for
/// [_i1.LoginScreen]
class LoginRoute extends _i2.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: 'login');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i1.SplitRsvp]
class SplitRsvp extends _i2.PageRouteInfo<void> {
  const SplitRsvp() : super(SplitRsvp.name, path: '/split-rsvp');

  static const String name = 'SplitRsvp';
}

/// generated route for
/// [_i1.DynamicRegistration]
class DynamicRegistrationRouter extends _i2.PageRouteInfo<void> {
  const DynamicRegistrationRouter()
      : super(DynamicRegistrationRouter.name, path: 'registration');

  static const String name = 'DynamicRegistrationRouter';
}

/// generated route for
/// [_i1.Dashboard]
class DashboardRouter extends _i2.PageRouteInfo<void> {
  const DashboardRouter() : super(DashboardRouter.name, path: 'dashboard');

  static const String name = 'DashboardRouter';
}

/// generated route for
/// [_i1.AdminDashboard]
class AdminDashboardRouter extends _i2.PageRouteInfo<void> {
  const AdminDashboardRouter({List<_i2.PageRouteInfo>? children})
      : super(AdminDashboardRouter.name,
            path: 'admin', initialChildren: children);

  static const String name = 'AdminDashboardRouter';
}

/// generated route for
/// [_i1.MainMenu]
class MainMenu extends _i2.PageRouteInfo<void> {
  const MainMenu() : super(MainMenu.name, path: 'main');

  static const String name = 'MainMenu';
}

/// generated route for
/// [_i1.StarterMenu]
class StarterMenu extends _i2.PageRouteInfo<void> {
  const StarterMenu() : super(StarterMenu.name, path: 'starter');

  static const String name = 'StarterMenu';
}

/// generated route for
/// [_i1.PendingGuests]
class PendingGuests extends _i2.PageRouteInfo<void> {
  const PendingGuests() : super(PendingGuests.name, path: 'guests');

  static const String name = 'PendingGuests';
}

/// generated route for
/// [_i1.ReservedGuests]
class ReservedGuests extends _i2.PageRouteInfo<void> {
  const ReservedGuests() : super(ReservedGuests.name, path: 'reserved');

  static const String name = 'ReservedGuests';
}
