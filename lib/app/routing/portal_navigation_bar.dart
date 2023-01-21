import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:kotlin_scope_function/kotlin_scope_function.dart";
import "package:portal/app/routing/navigation_entry.dart";
import "package:portal/app/routing/portal_navigation_widget.dart";

class PortalNavigationBar extends PortalNavigationWidget {
  const PortalNavigationBar({
    super.key,
    required super.selectedIndex,
    required super.onDestinationSelected,
    required super.destinations,
  });

  NavigationDestination _toNavigationDestination(
    NavigationEntry entry,
    BuildContext context,
  ) {
    final t = AppLocalizations.of(context)!;
    return NavigationDestination(
      icon: Icon(entry.icon),
      selectedIcon: entry.selectedIcon?.let((it) => Icon(entry.selectedIcon)),
      label: entry.destination.getLabel(t),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: (newDestinationIndex) =>
          onDestinationSelected(context, newDestinationIndex),
      destinations: destinations
          .map((e) => _toNavigationDestination(e, context))
          .toList(growable: false),
    );
  }
}
