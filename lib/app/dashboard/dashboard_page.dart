import "dart:async";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart";
import "package:go_router/go_router.dart";
import "package:portal/app/navigation/destination.dart";
import "package:portal/app/theme/paddings.dart";
import "package:portal/components/donate_card.dart";
import "package:portal/main.dart";
import "package:portal/styled_text/a_href_action_tag.dart";
import "package:styled_text/styled_text.dart";
import "package:url_launcher/url_launcher.dart";

class DashboardDestination extends DestinationWithoutParams {
  const DashboardDestination();

  @override
  final String location = "/dashboard";

  @override
  RouteBase build() => GoRoute(
        path: location,
        builder: (context, state) => const DashboardPage(),
      );
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final int columns;
    if (Breakpoints.small.isActive(context)) {
      columns = 1;
    } else if (const WidthPlatformBreakpoint(begin: 1800).isActive(context)) {
      columns = 3;
    } else {
      columns = 2;
    }
    return Scaffold(
      body: Container(
        color: theme.colorScheme.background,
        constraints: const BoxConstraints.expand(),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(
            Breakpoints.small.isActive(context)
                ? Paddings.small
                : Paddings.large,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: Paddings.extraExtraLarge,
                  horizontal: Paddings.large,
                ),
                child: Text(
                  t.labelDashboard,
                  style: theme.textTheme.displayLarge,
                ),
              ),
              StaggeredGrid.count(
                crossAxisCount: columns,
                children: [
                  Card(
                    elevation: 0,
                    color: theme.colorScheme.surfaceVariant,
                    child: Padding(
                      padding: const EdgeInsets.all(Paddings.cardContent),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Kontakt och hjälp",
                            style: theme.textTheme.headlineSmall!
                                .copyWith(color: theme.colorScheme.primary),
                          ),
                          const SizedBox(height: Paddings.large),
                          Text(
                            "Om du behöver hjälp kan du kontakta Dansdatas utvecklare på GitHub. Där går det bra att ställa frågor på både svenska och engelska.",
                            style: theme.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: Paddings.small),
                          Text(
                            "I vissa fall kan du även kontakta oss på dansdata@googlegroups.com. Vi ber dig dock i första hand att använda GitHub om det är möjligt.",
                            style: theme.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: Paddings.small),
                          StyledText.selectable(
                            text:
                                "Bifoga gärna versionsnummer i kontakt med oss: <a href=\"https://github.com/dansdata-se/portal/tree/${BuildConfig.gitCommitRef}\">${BuildConfig.gitCommitRef}</a>:<a href=\"https://github.com/dansdata-se/portal/tree/${BuildConfig.gitCommitSha}\">${BuildConfig.gitCommitSha.substring(0, 7)}</a> (${BuildConfig.vercelEnv.name})",
                            style: theme.textTheme.bodySmall,
                            tags: {"a": aHrefActionTag(context)},
                          ),
                          const SizedBox(height: Paddings.small),
                          Text(
                            "Tänk på att Dansdata utvecklas av frivilliga! Håll en god ton och var beredd på att vi kanske inte hinner besvara alla meddelanden med en gång.",
                            style: theme.textTheme.bodySmall,
                          ),
                          const SizedBox(height: Paddings.small),
                          Wrap(
                            alignment: WrapAlignment.end,
                            runSpacing: Paddings.extraSmall,
                            spacing: Paddings.small,
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  unawaited(
                                    Clipboard.setData(
                                      ClipboardData(
                                        text:
                                            "Dansdata Portal ${BuildConfig.gitCommitRef}:${BuildConfig.gitCommitSha.substring(0, 7)} (${BuildConfig.vercelEnv.name})",
                                      ),
                                    ).then((value) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Versionsnummer kopierat!",
                                          ),
                                        ),
                                      );
                                    }),
                                  );
                                },
                                child: const Text("Kopiera versionsnummer"),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: theme.colorScheme.onPrimary,
                                  backgroundColor: theme.colorScheme.primary,
                                ).copyWith(
                                  elevation: ButtonStyleButton.allOrNull(0.0),
                                ),
                                onPressed: () => unawaited(
                                  launchUrl(
                                    Uri.parse(
                                      "https://github.com/dansdata-se/portal/discussions",
                                    ),
                                  ),
                                ),
                                child: const Text("Få hjälp på GitHub"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const DonateCard(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
