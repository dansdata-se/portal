import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:kotlin_scope_function/kotlin_scope_function.dart";
import "package:portal/app/routing/navigation_entry.dart";
import "package:portal/app/routing/portal_navigation_widget.dart";
import "package:portal/app/routing/rail_drawer_trailing.dart";
import "package:portal/app/theme/paddings.dart";
import "package:portal/widgets/dansdata_logo.dart";

class PortalNavigationRail extends PortalNavigationWidget {
  const PortalNavigationRail({
    super.key,
    required super.selectedIndex,
    required super.onDestinationSelected,
    required super.destinations,
  });

  NavigationRailDestination _toNavigationRailDestination(
    NavigationEntry entry,
    BuildContext context,
  ) {
    final t = AppLocalizations.of(context)!;
    return NavigationRailDestination(
      icon: Icon(entry.icon),
      selectedIcon: entry.selectedIcon?.let((it) => Icon(it)),
      label: Text(entry.destination.getLabel(t), textAlign: TextAlign.center),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        restorationId: "portalNavigationRail.scroll",
        child: Container(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          width: 80,
          child: IntrinsicHeight(
            child: NavigationRail(
              selectedIndex: selectedIndex,
              onDestinationSelected: (newDestinationIndex) =>
                  onDestinationSelected(context, newDestinationIndex),
              destinations: destinations
                  .map((e) => _toNavigationRailDestination(e, context))
                  .toList(growable: false),
              unselectedLabelTextStyle:
                  TextStyle(color: theme.colorScheme.onSurfaceVariant),
              labelType: NavigationRailLabelType.all,
              leading: Column(
                children: [
                  const SizedBox(height: Paddings.large),
                  DansdataLogo(
                    logoSize: 56,
                    titleStyle: null,
                    taglineStyle: null,
                    border: theme.brightness == Brightness.light,
                  ),
                  const SizedBox(height: Paddings.extraExtraLarge),
                ],
              ),
              trailing: const RailDrawerTrailing(),
            ),
          ),
        ),
      ),
    );
  }
}
