import "package:flutter/widgets.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:portal/app/settings/language.dart";
import "package:portal/app/settings/language_setting.dart";
import "package:portal/app/theme/radii.dart";
import "package:portal/gen/assets.gen.dart";
import "package:provider/provider.dart";

/// A square icon with a flag for use in "change language" buttons.
class FlagIcon extends StatelessWidget {
  const FlagIcon({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return ClipRRect(
      borderRadius: BorderRadius.circular(Radii.small),
      child: (context.watch<LanguageSetting>().value == Language.swedish
              ? Assets.images.flags.ukSquare
              : Assets.images.flags.swedenSquare)
          .svg(
        height: size,
        width: size,
        fit: BoxFit.cover,
        semanticsLabel: t.semanticsSwitchLanguage,
      ),
    );
  }
}
