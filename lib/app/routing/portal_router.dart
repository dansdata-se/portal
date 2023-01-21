import "package:flutter/widgets.dart";
import "package:go_router/go_router.dart";
import "package:portal/app/auth/create_account_page.dart";
import "package:portal/app/auth/login_page.dart";
import "package:portal/app/auth/reset_password_page.dart";
import "package:portal/app/routing/portal_scaffold.dart";
import "package:portal/app/routing/primary_navigation_entries.dart";

RouterConfig<Object> buildRouterConfig() {
  return GoRouter(
    initialLocation: const LoginDestination().location,
    routes: [
      const CreateAccountDestination().build(),
      const LoginDestination().build(),
      const ResetPasswordDestination().build(),
      ShellRoute(
        builder: (context, state, child) {
          return PortalScaffold(
            state: state,
            destinations: PrimaryNavigationEntries.values,
            child: child,
          );
        },
        routes: PrimaryNavigationEntries.values
            .map((e) => e.destination.build())
            .toList(),
      ),
    ],
  );
}
