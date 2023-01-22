import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:portal/app/theme/paddings.dart";
import "package:portal/app/theme/radii.dart";
import "package:portal/app/theme/typography.dart";
import "package:portal/gen/assets.gen.dart";

class DansdataLogo extends StatelessWidget {
  static const Key titleKey = Key("dansdataLogo.title");
  static const Key taglineKey = Key("dansdataLogo.tagline");
  static const double _innerSpacing = Paddings.medium;

  const DansdataLogo({
    super.key,
    this.logoSize,
    this.titleStyle = const TextStyle(),
    this.taglineStyle = const TextStyle(),
    this.direction = Axis.horizontal,
    this.border = false,
    this.wrap = true,
  });

  final double? logoSize;

  /// The text style to use for the "Dansdata Portal" text.
  ///
  /// `null` means the "Dansdata Portal" text will be excluded.
  ///
  /// [Colors.transparent] can be used to reset the [TextStyle.color] of a given
  /// [TextStyle] (since `.copyWith(color: null)` is not supported at this
  /// time).
  final TextStyle? titleStyle;

  /// The text style to use for the tagline text.
  ///
  /// `null` means the tagline text will be excluded.
  ///
  /// [Colors.transparent] can be used to reset the [TextStyle.color] of a given
  /// [TextStyle] (since `.copyWith(color: null)` is not supported at this
  /// time).
  final TextStyle? taglineStyle;
  final Axis direction;

  /// Whether a border should be rendered around the logo image.
  final bool border;

  /// Whether the text in this widget should automatically wrap if there is not
  /// enough space along the given [direction].
  final bool wrap;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return _directionalContainer(
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
        if (!wrap)
          SizedBox(
            width: direction == Axis.horizontal ? _innerSpacing : 0,
            height: direction == Axis.vertical ? _innerSpacing : 0,
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
                        ).merge(
                          titleStyle
                              ?.withDefaultColor(theme.colorScheme.primary),
                        ),
                      ),
                      TextSpan(
                        text: "Portal",
                        style: brandTextStyle(
                          textStyle: theme.textTheme.headlineMedium,
                          color: theme.colorScheme.onSurfaceVariant,
                        ).merge(
                          titleStyle?.withDefaultColor(
                            theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
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
                  ).merge(
                    taglineStyle?.withDefaultColor(theme.colorScheme.onSurface),
                  ),
                ),
            ],
          )
      ],
    );
  }

  Widget _directionalContainer({required List<Widget> children}) {
    if (wrap) {
      return Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        direction: direction,
        spacing: _innerSpacing,
        runSpacing: _innerSpacing,
        children: children,
      );
    }

    if (direction == Axis.horizontal) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
}

extension _DefaultColor on TextStyle {
  TextStyle withDefaultColor(Color color) {
    if (this.color == null || this.color == Colors.transparent) {
      return copyWith(color: color);
    } else {
      return this;
    }
  }
}
