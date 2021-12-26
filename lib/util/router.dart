import 'package:auto_route/auto_route.dart';
import 'package:weddingrsvp/screens/screens.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomeScreen, initial: true),
    AutoRoute(path: 'login', name: 'LoginRoute', page: LoginScreen),
    AutoRoute(page: SplitRsvp),
    AutoRoute(
      page: DynamicRegistration,
      name: 'DynamicRegistrationRouter',
      path: 'registration',
    ),
    AutoRoute(
        path: 'dashboard',
        name: 'DashboardRouter',
        page: Dashboard,
        children: [
        ]),
    AutoRoute(
        path: 'admin',
        name: 'AdminDashboardRouter',
        page: AdminDashboard,
        guards: [
          AuthGuard
        ],
        children: [
          AutoRoute(path: 'main', page: MainMenu, initial: true),
          AutoRoute(path: 'starter', page: StarterMenu),
          AutoRoute(path: 'guests', page: PendingGuests),
          AutoRoute(path: 'reserved', page: ReservedGuests)
        ]),
  ],
)
class $AppRouter {}

class AuthGuard extends AutoRouteGuard {
  bool authenticated = true;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
// the navigation is paused until resolver.next() is called with either
// true to resume/continue navigation or false to abort navigation
    if (authenticated) {
// if user is authenticated we continue
      resolver.next(true);
    } else {
// we redirect the user to our login page
      router.replaceNamed('login');
    }
  }
}
