import "package:flutter/material.dart";
import "package:portal/app/routing/navigation_entry.dart";

abstract class PortalNavigationWidget extends StatelessWidget {
  const PortalNavigationWidget({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
  });

  final int selectedIndex;
  final void Function(BuildContext context, int newDestinationIndex)
      onDestinationSelected;
  final List<NavigationEntry> destinations;
}
