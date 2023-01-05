import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:portal/app/theme/paddings.dart";
import "package:portal/app/theme/radii.dart";
import "package:portal/app/theme/typography.dart";
import "package:portal/gen/assets.gen.dart";

class DansdataLogo extends StatelessWidget {
  static const Key titleKey = Key("dansdataLogo.title");
  static const Key taglineKey = Key("dansdataLogo.tagline");

  const DansdataLogo({
    super.key,
    this.logoSize,
    this.titleStyle = const TextStyle(),
    this.taglineStyle = const TextStyle(),
    this.direction = Axis.horizontal,
    this.border = false,
  });

  final double? logoSize;

  /// The text style to use for the "Dansdata Portal" text.
  ///
  /// `null` means the "Dansdata Portal" text will be excluded.
  final TextStyle? titleStyle;

  /// The text style to use for the tagline text.
  ///
  /// `null` means the tagline text will be excluded.
  final TextStyle? taglineStyle;
  final Axis direction;
  final bool border;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: direction,
      spacing: Paddings.medium,
      runSpacing: Paddings.medium,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Radii.large),
            border: border ? Border.all(color: theme.dividerColor) : null,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Assets.images.logo.image(
              isAntiAlias: true,
              excludeFromSemantics: true,
              height: logoSize,
              width: logoSize,
            ),
          ),
        ),
        if (titleStyle != null || taglineStyle != null)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: direction == Axis.horizontal
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              if (titleStyle != null)
                RichText(
                  key: titleKey,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Dansdata ",
                        style: brandTextStyle(
                          textStyle: theme.textTheme.headlineMedium,
                          color: theme.colorScheme.primary,
                        ).merge(titleStyle),
                      ),
                      TextSpan(
                        text: "Portal",
                        style: brandTextStyle(
                          textStyle: theme.textTheme.headlineMedium,
                          color: theme.colorScheme.onSurfaceVariant,
                        ).merge(titleStyle),
                      ),
                    ],
                  ),
                ),
              if (taglineStyle != null)
                Text(
                  t.tagline,
                  key: taglineKey,
                  style: plainTextStyle(
                    textStyle: theme.textTheme.labelSmall,
                    color: theme.colorScheme.onSurface,
                  ).merge(taglineStyle),
                ),
            ],
          )
      ],
    );
  }
}
