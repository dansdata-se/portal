import "package:flutter/widgets.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:portal/app/theme/radii.dart";
import "package:portal/gen/assets.gen.dart";
import "package:portal/l10n/language.dart";
import "package:portal/l10n/language_setting.dart";
import "package:provider/provider.dart";

/// An icon with a flag for use in "change language" buttons.
class FlagIcon extends StatelessWidget {
  const FlagIcon({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return ClipRRect(
      borderRadius: BorderRadius.circular(Radii.small),
      child: (context.watch<LanguageSetting>().value == Language.swedish
              ? Assets.images.flags.gbSquare
              : Assets.images.flags.seSquare)
          .svg(
        height: size,
        width: size,
        fit: BoxFit.cover,
        semanticsLabel: t.semanticsSwitchLanguage,
      ),
    );
  }
}
