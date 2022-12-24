import "dart:async";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:go_router/go_router.dart";
import "package:portal/app/account/account_page.dart";
import "package:portal/app/api/api_page.dart";
import "package:portal/app/auth/user_controller.dart";
import "package:portal/app/dashboard/dashboard_page.dart";
import "package:portal/app/events/events_page.dart";
import "package:portal/app/navigation/destination.dart";
import "package:portal/app/profiles/profiles_page.dart";
import "package:portal/app/settings/flag_icon.dart";
import "package:portal/app/settings/language_setting.dart";
import "package:portal/app/settings/theme_mode_icon.dart";
import "package:portal/app/settings/theme_mode_setting.dart";
import "package:portal/app/theme/paddings.dart";
import "package:portal/components/dansdata_logo.dart";
import "package:portal/components/portal_app_bar.dart";
import "package:portal/extensions/breakpoint_when_active.dart";
import "package:provider/provider.dart";

// Note: The enum order is used to determine the order of navigation entries!
enum PortalScaffoldDestinations {
  dashboard(
    Icons.dashboard_outlined,
    _labelDashboard,
    DashboardDestination(),
  ),
  events(
    Icons.event_outlined,
    _labelEvents,
    EventsDestination(),
  ),
  profiles(
    Icons.supervised_user_circle_outlined,
    _labelProfiles,
    ProfilesDestination(),
  ),
  api(
    Icons.code_outlined,
    _labelApi,
    ApiDestination(),
  ),
  account(
    Icons.account_circle_outlined,
    _labelAccount,
    AccountDestination(),
  );

  const PortalScaffoldDestinations(this.icon, this.getLabel, this.destination);

  final IconData icon;
  final String Function(AppLocalizations t) getLabel;
  final DestinationWithoutParams destination;

  static String _labelDashboard(AppLocalizations t) => t.labelDashboard;
  static String _labelEvents(AppLocalizations t) => t.labelEvents;
  static String _labelProfiles(AppLocalizations t) => t.labelProfiles;
  static String _labelApi(AppLocalizations t) => t.labelApi;
  static String _labelAccount(AppLocalizations t) => t.labelAccount;

  NavigationDestination toNavigationDestination(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return NavigationDestination(
      icon: Icon(icon),
      label: getLabel(t),
    );
  }

  NavigationRailDestination toNavigationRailDestination(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return NavigationRailDestination(
      icon: Icon(icon),
      label: Text(getLabel(t), textAlign: TextAlign.center),
    );
  }
}

class PortalScaffold extends StatelessWidget {
  static const Key bodyKey = Key("body");
  static const Key navigationKey = Key("navigation");

  const PortalScaffold({
    super.key,
    required this.state,
    required this.child,
  });

  final GoRouterState state;
  final Widget child;

  @visibleForTesting
  int getSelectedDestinationIndex() {
    final fullPath = state.fullpath;
    if (fullPath != null) {
      return PortalScaffoldDestinations.values.firstWhere(
        (it) => fullPath.startsWith(it.destination.location),
        orElse: () {
          if (kDebugMode) {
            throw StateError("No destination defined for path $fullPath!");
          }
          return PortalScaffoldDestinations.dashboard;
        },
      ).index;
    }
    if (kDebugMode) {
      throw StateError("No destination defined for path $fullPath!");
    }
    return PortalScaffoldDestinations.dashboard.index;
  }

  void _onDestinationSelected(BuildContext context, int newDestinationIndex) {
    PortalScaffoldDestinations.values[newDestinationIndex].destination
        .go(context);
  }

  void _onToggleThemeMode(BuildContext context) {
    final theme = Theme.of(context);
    unawaited(
      context.read<ThemeModeSetting>().update(
            theme.brightness == Brightness.light
                ? ThemeMode.dark
                : ThemeMode.light,
          ),
    );
  }

  static void _onToggleLanguage(BuildContext context) {
    unawaited(context.read<LanguageSetting>().toggle());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          Breakpoints.small.isActive(context) ? PortalAppBar.of(context) : null,
      body: AdaptiveLayout(
        internalAnimations: false,
        primaryNavigation: Breakpoints.mediumAndUp.whenActive(
          context,
          SlotLayout(
            config: {
              Breakpoints.medium: SlotLayout.from(
                key: PortalScaffold.navigationKey,
                builder: _navigationRailBuilder(extended: false),
              ),
              Breakpoints.large: SlotLayout.from(
                key: PortalScaffold.navigationKey,
                builder: _navigationRailBuilder(extended: true),
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
                builder: _navigationBar,
              ),
            },
          ),
        ),
        body: SlotLayout(
          config: {
            Breakpoints.smallAndUp: SlotLayout.from(
              key: PortalScaffold.bodyKey,
              builder: (_) => Container(
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(),
                constraints: const BoxConstraints.expand(),
                child: child,
              ),
            ),
          },
        ),
      ),
    );
  }

/* todo(FelixZY): Implement NavigationDrawer when flutter > 3.3.x.

  WidgetBuilder _drawerNavigationBuilder({required bool extended}) =>
      (BuildContext context) {
        throw UnimplementedError(
          "NavigationDrawer not available in flutter 3.3.x!",
        );
      };
*/

  WidgetBuilder _navigationRailBuilder({required bool extended}) =>
      (BuildContext context) {
        final theme = Theme.of(context);
        return LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            restorationId: "portalScaffold.navrail",
            child: Container(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              width: extended ? 280 : 80,
              child: IntrinsicHeight(
                child: NavigationRail(
                  selectedIndex: getSelectedDestinationIndex(),
                  onDestinationSelected: (newDestinationIndex) =>
                      _onDestinationSelected(context, newDestinationIndex),
                  destinations: PortalScaffoldDestinations.values
                      .map((e) => e.toNavigationRailDestination(context))
                      .toList(growable: false),
                  unselectedLabelTextStyle:
                      TextStyle(color: theme.colorScheme.onSurfaceVariant),
                  labelType: extended
                      ? NavigationRailLabelType.none
                      : NavigationRailLabelType.all,
                  extended: extended,
                  leading: Column(
                    children: [
                      const SizedBox(height: Paddings.large),
                      DansdataLogo(
                        logoSize: 56,
                        textSize: extended
                            ? theme.textTheme.headlineSmall?.fontSize
                            : null,
                        taglineSize: extended
                            ? theme.textTheme.labelSmall?.fontSize
                            : null,
                        border: true,
                      ),
                      const SizedBox(height: Paddings.extraExtraLarge),
                    ],
                  ),
                  trailing: Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: Paddings.extraExtraLarge,
                          bottom: Paddings.large,
                        ),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          runSpacing: Paddings.medium,
                          children: [
                            _outlinedIconButton(
                              context,
                              onPressed: () => _onToggleThemeMode(context),
                              size: const Size.square(40),
                              child: const ThemeModeIcon(size: 18),
                            ),
                            _outlinedIconButton(
                              context,
                              onPressed: () => _onToggleLanguage(context),
                              size: const Size.square(40),
                              child: const FlagIcon(size: 18),
                            ),
                            // Mobile users will need to visit the "account" page to
                            // log out.
                            _outlinedIconButton(
                              context,
                              onPressed: () => unawaited(
                                context.read<UserController>().logout(),
                              ),
                              size: const Size.square(40),
                              child:
                                  const Icon(Icons.logout_outlined, size: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      };

  Widget _navigationBar(BuildContext context) {
    return NavigationBar(
      selectedIndex: getSelectedDestinationIndex(),
      onDestinationSelected: (newDestinationIndex) =>
          _onDestinationSelected(context, newDestinationIndex),
      destinations: PortalScaffoldDestinations.values
          .map((e) => e.toNavigationDestination(context))
          .toList(growable: false),
    );
  }

  Widget _outlinedIconButton(
    BuildContext context, {
    required void Function()? onPressed,
    required Widget child,
    Size? size,
  }) {
    final theme = Theme.of(context);
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape: const CircleBorder(),
        fixedSize: size,
        foregroundColor: theme.colorScheme.onSurfaceVariant,
      ),
      child: child,
    );
  }
}
