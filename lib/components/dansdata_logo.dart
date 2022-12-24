import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:portal/app/theme/paddings.dart";
import "package:portal/app/theme/radii.dart";
import "package:portal/app/theme/typography.dart";
import "package:portal/gen/assets.gen.dart";

class DansdataLogo extends StatelessWidget {
  const DansdataLogo({
    super.key,
    this.logoSize,
    this.textSize,
    this.taglineSize,
    this.direction = Axis.horizontal,
    this.border = false,
  });

  final double? logoSize;

  /// The text style to use for the "Dansdata Portal" text.
  ///
  /// `null` means the "Dansdata Portal" text will be excluded.
  final double? textSize;

  /// The text style to use for the tagline text.
  ///
  /// `null` means the tagline text will be excluded.
  final double? taglineSize;
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
        if (textSize != null || taglineSize != null)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: direction == Axis.horizontal
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              if (textSize != null)
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Dansdata ",
                        style: brandTextStyle(
                          fontSize: textSize,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      TextSpan(
                        text: "Portal",
                        style: brandTextStyle(
                          fontSize: textSize,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              if (taglineSize != null)
                Text(
                  t.tagline,
                  style: plainTextStyle(
                    fontSize: taglineSize,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
            ],
          )
      ],
    );
  }
}
