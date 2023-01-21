import "package:flutter/material.dart";
import "package:portal/app/account/account_page.dart";
import "package:portal/app/api/api_page.dart";
import "package:portal/app/dashboard/dashboard_page.dart";
import "package:portal/app/events/events_page.dart";
import "package:portal/app/profiles/profiles_page.dart";
import "package:portal/app/routing/destination.dart";
import "package:portal/app/routing/navigation_entry.dart";

/// The [NavigationEntry]s used for primary navigation in the portal.
///
/// Note: The enum order is used to determine the order of navigation entries!
enum PrimaryNavigationEntries implements NavigationEntry {
  dashboard(
    icon: Icons.dashboard_outlined,
    selectedIcon: Icons.dashboard,
    destination: DashboardDestination(),
  ),
  events(
    icon: Icons.event_outlined,
    selectedIcon: Icons.event,
    destination: EventsDestination(),
  ),
  profiles(
    icon: Icons.supervised_user_circle_outlined,
    selectedIcon: Icons.supervised_user_circle,
    destination: ProfilesDestination(),
  ),
  api(
    icon: Icons.code_outlined,
    selectedIcon: Icons.code,
    destination: ApiDestination(),
  ),
  account(
    icon: Icons.account_circle_outlined,
    selectedIcon: Icons.account_circle,
    destination: AccountDestination(),
  );

  const PrimaryNavigationEntries({
    required this.icon,
    required this.selectedIcon,
    required this.destination,
  });

  @override
  final IconData icon;
  @override
  final IconData selectedIcon;
  @override
  final DestinationWithoutParams destination;
}
