import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart";
import "package:go_router/go_router.dart";
import "package:portal/app/routing/navigation_entry.dart";
import "package:portal/app/routing/portal_app_bar.dart";
import "package:portal/app/routing/portal_navigation_bar.dart";
import "package:portal/app/routing/portal_navigation_drawer.dart";
import "package:portal/app/routing/portal_navigation_rail.dart";
import "package:portal/app/routing/primary_navigation_entries.dart";
import "package:portal/flutter_adaptive_scaffold/breakpoint_when_active.dart";
import "package:portal/flutter_adaptive_scaffold/custom_breakpoints.dart";

class PortalScaffold extends StatelessWidget {
  static const Key bodyKey = Key("portalScaffold.body");
  static const Key navigationKey = Key("portalScaffold.navigation");

  const PortalScaffold({
    super.key,
    required this.state,
    required this.destinations,
    required this.child,
  });

  final GoRouterState state;
  final List<NavigationEntry> destinations;
  final Widget child;

  @visibleForTesting
  static int getSelectedDestinationIndex(String? fullPath) {
    if (fullPath == null) {
      if (kDebugMode) {
        throw StateError("No destination defined for path $fullPath!");
      }
      return PrimaryNavigationEntries.dashboard.index;
    }

    return PrimaryNavigationEntries.values.firstWhere(
      (it) => fullPath.startsWith(it.destination.location),
      orElse: () {
        if (kDebugMode) {
          throw StateError("No destination defined for path $fullPath!");
        }
        return PrimaryNavigationEntries.dashboard;
      },
    ).index;
  }

  void _onDestinationSelected(BuildContext context, int newDestinationIndex) {
    PrimaryNavigationEntries.values[newDestinationIndex].destination
        .go(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          Breakpoints.small.isActive(context) ? PortalAppBar.of(context) : null,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: AdaptiveLayout(
        internalAnimations: false,
        primaryNavigation: Breakpoints.mediumAndUp.whenActive(
          context,
          SlotLayout(
            config: {
              Breakpoints.mediumAndUp: SlotLayout.from(
                key: PortalScaffold.navigationKey,
                builder: (builder) => PortalNavigationRail(
                  selectedIndex: getSelectedDestinationIndex(state.fullpath),
                  onDestinationSelected: _onDestinationSelected,
                  destinations: destinations,
                ),
              ),
              CustomBreakpoints.extraLarge: SlotLayout.from(
                key: PortalScaffold.navigationKey,
                builder: (context) => PortalNavigationDrawer(
                  selectedIndex: getSelectedDestinationIndex(state.fullpath),
                  onDestinationSelected: _onDestinationSelected,
                  destinations: destinations,
                ),
              ),
            },
          ),
        ),
        bottomNavigation: Breakpoints.small.whenActive(
          context,
          SlotLayout(
            config: {
              Breakpoints.small: SlotLayout.from(
                key: PortalScaffold.navigationKey,
                builder: (context) => PortalNavigationBar(
                  selectedIndex: getSelectedDestinationIndex(state.fullpath),
                  onDestinationSelected: _onDestinationSelected,
                  destinations: destinations,
                ),
              ),
            },
          ),
        ),
        body: SlotLayout(
          config: {
            Breakpoints.smallAndUp: SlotLayout.from(
              key: PortalScaffold.bodyKey,
              builder: (context) {
                // Clip overflowing body content
                return Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(),
                  constraints: const BoxConstraints.expand(),
                  child: child,
                );
              },
            ),
          },
        ),
      ),
    );
  }
}
