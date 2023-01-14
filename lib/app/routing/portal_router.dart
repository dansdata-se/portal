import "package:flutter/widgets.dart";
import "package:go_router/go_router.dart";
import "package:portal/app/account/account_page.dart";
import "package:portal/app/api/api_page.dart";
import "package:portal/app/auth/create_account_page.dart";
import "package:portal/app/auth/login_page.dart";
import "package:portal/app/auth/reset_password_page.dart";
import "package:portal/app/dashboard/dashboard_page.dart";
import "package:portal/app/events/events_page.dart";
import "package:portal/app/profiles/profiles_page.dart";

RouterConfig<Object> buildRouterConfig() {
  return GoRouter(
    initialLocation: const LoginDestination().location,
    routes: [
      const AccountDestination().build(),
      const ApiDestination().build(),
      const CreateAccountDestination().build(),
      const DashboardDestination().build(),
      const EventsDestination().build(),
      const LoginDestination().build(),
      const ProfilesDestination().build(),
      const ResetPasswordDestination().build(),
    ],
  );
}
