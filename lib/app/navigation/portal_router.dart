import "package:flutter/widgets.dart";
import "package:go_router/go_router.dart";
import "package:portal/app/auth/login_page.dart";
import "package:portal/app/auth/user_controller.dart";
import "package:portal/app/dashboard/dashboard_page.dart";
import "package:portal/app/navigation/portal_scaffold.dart";
import "package:provider/provider.dart";

final _unrestrictedLocations = [const LoginDestination().location];
final _redirectIfLoggedInLocations = [
  "/",
  const LoginDestination().location,
];

RouterConfig<Object> buildRouterConfig() {
  return GoRouter(
    initialLocation: "/",
    redirect: _redirect,
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => throw UnimplementedError(
          "The router is expected to perform a redirect before this route is reached.",
        ),
      ),
      const LoginDestination().build(),
      ShellRoute(
        builder: (context, state, child) {
          return PortalScaffold(state: state, child: child);
        },
        routes: PortalScaffoldDestinations.values
            .map((e) => e.destination.build())
            .toList(),
      )
    ],
  );
}

String? _redirect(BuildContext context, GoRouterState state) {
  final userController = context.read<UserController>();

  if (userController.isLoggedIn) {
    if (_redirectIfLoggedInLocations.contains(state.subloc)) {
      return const DashboardDestination().location;
    }
  } else {
    if (!_unrestrictedLocations.contains(state.subloc)) {
      return const LoginDestination().location;
    }
  }

  // No redirect
  return null;
}
