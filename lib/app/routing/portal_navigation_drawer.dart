import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:kotlin_scope_function/kotlin_scope_function.dart";
import "package:portal/app/routing/navigation_entry.dart";
import "package:portal/app/routing/portal_navigation_widget.dart";
import "package:portal/app/routing/rail_drawer_trailing.dart";
import "package:portal/app/theme/paddings.dart";
import "package:portal/widgets/dansdata_logo.dart";

class PortalNavigationDrawer extends PortalNavigationWidget {
  const PortalNavigationDrawer({
    super.key,
    required super.selectedIndex,
    required super.onDestinationSelected,
    required super.destinations,
  });

  NavigationDrawerDestination _toNavigationDrawerDestination(
    NavigationEntry entry,
    BuildContext context,
  ) {
    final t = AppLocalizations.of(context)!;
    return NavigationDrawerDestination(
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
        restorationId: "portalNavigationDrawer.scroll",
        child: Container(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: IntrinsicHeight(
            child: NavigationDrawer(
              elevation: 0,
              selectedIndex: selectedIndex,
              onDestinationSelected: (newDestinationIndex) =>
                  onDestinationSelected(context, newDestinationIndex),
              children: [
                const SizedBox(height: Paddings.large),
                Align(
                  child: DansdataLogo(
                    logoSize: 56,
                    titleStyle: theme.textTheme.headlineSmall!
                        // transparent to signal "no color override intended"
                        .copyWith(color: Colors.transparent),
                    taglineStyle: theme.textTheme.labelSmall!
                        // transparent to signal "no color override intended"
                        .copyWith(color: Colors.transparent),
                    border: theme.brightness == Brightness.light,
                  ),
                ),
                const SizedBox(height: Paddings.extraExtraLarge),
                ...destinations
                    .map((e) => _toNavigationDrawerDestination(e, context))
                    .toList(growable: false),
                const RailDrawerTrailing(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
