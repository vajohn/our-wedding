// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i3;
import 'package:flutter/widgets.dart' as _i5;

import '../models/guests.dart' as _i6;
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
    GuestRegistrationRouter.name: (routeData) {
      final args = routeData.argsAs<GuestRegistrationRouterArgs>();
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i1.GuestRegistration(
              key: args.key, guestRsvpData: args.guestRsvpData));
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
    BrideGuests.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.BrideGuests());
    },
    MainMenu.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.MainMenu());
    },
    StarterMenu.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.StarterMenu());
    },
    GroomGuests.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.GroomGuests());
    }
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig(HomeScreen.name, path: '/'),
        _i2.RouteConfig(LoginRoute.name, path: 'login'),
        _i2.RouteConfig(SplitRsvp.name, path: '/split-rsvp'),
        _i2.RouteConfig(GuestRegistrationRouter.name,
            path: 'guest-registration'),
        _i2.RouteConfig(DynamicRegistrationRouter.name, path: 'registration'),
        _i2.RouteConfig(DashboardRouter.name, path: 'dashboard', children: [
          _i2.RouteConfig('#redirect',
              path: '',
              parent: DashboardRouter.name,
              redirectTo: 'bride',
              fullMatch: true),
          _i2.RouteConfig(BrideGuests.name,
              path: 'bride', parent: DashboardRouter.name)
        ]),
        _i2.RouteConfig(AdminDashboardRouter.name, path: 'admin', guards: [
          authGuard
        ], children: [
          _i2.RouteConfig('#redirect',
              path: '',
              parent: AdminDashboardRouter.name,
              redirectTo: 'menu/main',
              fullMatch: true),
          _i2.RouteConfig(MainMenu.name,
              path: 'menu/main', parent: AdminDashboardRouter.name),
          _i2.RouteConfig(StarterMenu.name,
              path: 'menu/starter', parent: AdminDashboardRouter.name),
          _i2.RouteConfig(BrideGuests.name,
              path: 'bride', parent: AdminDashboardRouter.name),
          _i2.RouteConfig(GroomGuests.name,
              path: 'groom', parent: AdminDashboardRouter.name)
        ])
      ];
}

/// generated route for [_i1.HomeScreen]
class HomeScreen extends _i2.PageRouteInfo<void> {
  const HomeScreen() : super(name, path: '/');

  static const String name = 'HomeScreen';
}

/// generated route for [_i1.LoginScreen]
class LoginRoute extends _i2.PageRouteInfo<void> {
  const LoginRoute() : super(name, path: 'login');

  static const String name = 'LoginRoute';
}

/// generated route for [_i1.SplitRsvp]
class SplitRsvp extends _i2.PageRouteInfo<void> {
  const SplitRsvp() : super(name, path: '/split-rsvp');

  static const String name = 'SplitRsvp';
}

/// generated route for [_i1.GuestRegistration]
class GuestRegistrationRouter
    extends _i2.PageRouteInfo<GuestRegistrationRouterArgs> {
  GuestRegistrationRouter(
      {_i5.Key? key, required _i6.GuestRsvpData? guestRsvpData})
      : super(name,
            path: 'guest-registration',
            args: GuestRegistrationRouterArgs(
                key: key, guestRsvpData: guestRsvpData));

  static const String name = 'GuestRegistrationRouter';
}

class GuestRegistrationRouterArgs {
  const GuestRegistrationRouterArgs({this.key, required this.guestRsvpData});

  final _i5.Key? key;

  final _i6.GuestRsvpData? guestRsvpData;

  @override
  String toString() {
    return 'GuestRegistrationRouterArgs{key: $key, guestRsvpData: $guestRsvpData}';
  }
}

/// generated route for [_i1.DynamicRegistration]
class DynamicRegistrationRouter extends _i2.PageRouteInfo<void> {
  const DynamicRegistrationRouter() : super(name, path: 'registration');

  static const String name = 'DynamicRegistrationRouter';
}

/// generated route for [_i1.Dashboard]
class DashboardRouter extends _i2.PageRouteInfo<void> {
  const DashboardRouter({List<_i2.PageRouteInfo>? children})
      : super(name, path: 'dashboard', initialChildren: children);

  static const String name = 'DashboardRouter';
}

/// generated route for [_i1.AdminDashboard]
class AdminDashboardRouter extends _i2.PageRouteInfo<void> {
  const AdminDashboardRouter({List<_i2.PageRouteInfo>? children})
      : super(name, path: 'admin', initialChildren: children);

  static const String name = 'AdminDashboardRouter';
}

/// generated route for [_i1.BrideGuests]
class BrideGuests extends _i2.PageRouteInfo<void> {
  const BrideGuests() : super(name, path: 'bride');

  static const String name = 'BrideGuests';
}

/// generated route for [_i1.MainMenu]
class MainMenu extends _i2.PageRouteInfo<void> {
  const MainMenu() : super(name, path: 'menu/main');

  static const String name = 'MainMenu';
}

/// generated route for [_i1.StarterMenu]
class StarterMenu extends _i2.PageRouteInfo<void> {
  const StarterMenu() : super(name, path: 'menu/starter');

  static const String name = 'StarterMenu';
}

/// generated route for [_i1.GroomGuests]
class GroomGuests extends _i2.PageRouteInfo<void> {
  const GroomGuests() : super(name, path: 'groom');

  static const String name = 'GroomGuests';
}
