import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:portal/app/settings/language.dart";
import "package:portal/app/settings/language_setting.dart";
import "package:portal/app/theme/paddings.dart";
import "package:portal/gen/assets.gen.dart";
import "package:portal/styled_text/a_href_action_tag.dart";
import "package:provider/provider.dart";
import "package:styled_text/styled_text.dart";
import "package:url_launcher/url_launcher.dart";

class DonateCard extends StatelessWidget {
  static final Uri _githubUri = Uri.parse("https://github.com/dansdata-se");
  static final Uri _swishUriSv = Uri.parse(
    "https://app.swish.nu/1/p/sw/?sw=0769358122&msg=Frivillig%20donation%20till%20Dansdata&src=qr",
  );
  static final Uri _swishUriEn = Uri.parse(
    "https://app.swish.nu/1/p/sw/?sw=0769358122&msg=Voluntary%20Donation%20for%20Dansdata&src=qr",
  );
  static final Uri _economyUri = Uri.parse(
    "https://docs.google.com/spreadsheets/d/1Q4KKNtrvEGZ7xSHi0-0clf7wrCzKvp-uaVGohXMf0kU/edit?usp=sharing",
  );

  const DonateCard({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final AssetGenImage swishImage;
    switch (context.watch<LanguageSetting>().value) {
      case Language.swedish:
        swishImage = Assets.images.swishDonateSv;
        break;
      case Language.english:
        swishImage = Assets.images.swishDonateEn;
        break;
    }

    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceVariant,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (const WidthPlatformBreakpoint(begin: 1300).isActive(context))
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: Paddings.cardContent,
                    left: Paddings.cardContent,
                    bottom: Paddings.cardContent,
                  ),
                  child: swishImage.image(fit: BoxFit.contain),
                ),
              ),
            if (const WidthPlatformBreakpoint(begin: 1300).isActive(context))
              const SizedBox(width: Paddings.medium),
            Flexible(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(
                  top: Paddings.cardContent,
                  left: const WidthPlatformBreakpoint(begin: 1300)
                          .isActive(context)
                      ? Paddings.none
                      : Paddings.cardContent,
                  right: Paddings.cardContent,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Stötta utvecklingen",
                      style: theme.textTheme.headlineSmall!
                          .copyWith(color: theme.colorScheme.primary),
                    ),
                    const SizedBox(height: Paddings.large),
                    if (const WidthPlatformBreakpoint(end: 1300)
                        .isActive(context))
                      swishImage.image(height: 300, fit: BoxFit.contain),
                    if (const WidthPlatformBreakpoint(end: 1300)
                        .isActive(context))
                      const SizedBox(height: Paddings.small),
                    Text(
                      "Dansdata är en gratis plattform som utvecklas på frivillig basis med öppen källkod.",
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: Paddings.small),
                    StyledText(
                      text:
                          "Vill du trots detta bidra till våra <a href=\"$_economyUri\">driftkostnader</a> m.m. mottages donationer via Swish tacksamt!",
                      style: theme.textTheme.bodyMedium,
                      tags: {
                        "a": aHrefActionTag(context),
                      },
                    ),
                    const SizedBox(height: Paddings.small),
                    Text(
                      "Du får också gärna bidra med kod direkt på GitHub - tillsammans digitaliserar vi dansen i Sverige!",
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: Paddings.large),
                    StyledText(
                      text:
                          "Eventuella donationer går direkt till projektets maintainer (\"ansvarig utvecklare\") - för närvarande ${t.currentMaintainerNameWithLink}.",
                      style: theme.textTheme.bodySmall,
                      tags: {
                        "a": aHrefActionTag(context),
                      },
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: Paddings.cardContent,
                          ),
                          child: Wrap(
                            alignment: WrapAlignment.end,
                            runSpacing: Paddings.extraSmall,
                            spacing: Paddings.small,
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  final Uri swishUri;
                                  switch (
                                      context.read<LanguageSetting>().value) {
                                    case Language.swedish:
                                      swishUri = _swishUriSv;
                                      break;
                                    case Language.english:
                                      swishUri = _swishUriEn;
                                      break;
                                  }
                                  unawaited(launchUrl(swishUri));
                                },
                                child: const Text("Öppna Swish"),
                              ),
                              OutlinedButton(
                                onPressed: () =>
                                    unawaited(launchUrl(_githubUri)),
                                child: const Text("Dansdata på GitHub"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
