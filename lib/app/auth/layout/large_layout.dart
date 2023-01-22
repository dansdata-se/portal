import "package:flutter/material.dart";
import "package:portal/app/auth/layout/auth_layout_view_model.dart";
import "package:portal/app/theme/paddings.dart";
import "package:portal/app/theme/radii.dart";
import "package:portal/app/theme/theme_mode_click_handler.dart";
import "package:portal/app/theme/theme_mode_icon.dart";
import "package:portal/l10n/flag_icon.dart";
import "package:portal/l10n/language_click_handler.dart";
import "package:portal/widgets/dansdata_logo.dart";
import "package:provider/provider.dart";

class LargeLayout extends StatefulWidget {
  static const Key languageToggleKey = Key("authLayout.largeLayout.language");
  static const Key themeModeToggleKey = Key("authLayout.largeLayout.themeMode");

  const LargeLayout({super.key, required this.child});

  final Widget child;

  @override
  State<StatefulWidget> createState() => _LargeLayoutState();
}

class _LargeLayoutState extends State<LargeLayout>
    with ThemeModeClickHandler, LanguageClickHandler {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final theme = Theme.of(context);
    final viewModel = Provider.of<AuthLayoutViewModel>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.updateFabs([
        FloatingActionButton.small(
          key: LargeLayout.themeModeToggleKey,
          backgroundColor: theme.colorScheme.surface,
          foregroundColor: theme.colorScheme.primary,
          onPressed: () => onToggleThemeClick(context),
          child: const ThemeModeIcon(),
        ),
        FloatingActionButton.small(
          key: LargeLayout.languageToggleKey,
          backgroundColor: theme.colorScheme.surface,
          foregroundColor: theme.colorScheme.primary,
          onPressed: () => onToggleLanguageClick(context),
          child: const FlagIcon(size: 24),
        ),
      ]);
    });
  }

  @override
  void deactivate() {
    final viewModel = Provider.of<AuthLayoutViewModel>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!viewModel.isDisposed) {
        viewModel.clearFabs();
      }
    });

    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Padding(
            padding: const EdgeInsets.all(Paddings.large),
            child: Builder(
              builder: (context) {
                final theme = Theme.of(context);
                return Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: theme.colorScheme.outline),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(Radii.card)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(Paddings.extraLarge),
                    child: IntrinsicWidth(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          DansdataLogo(
                            logoSize: theme.textTheme.displayLarge!.fontSize,
                            titleStyle: theme.textTheme.displayMedium!
                                .copyWith(color: Colors.transparent),
                            taglineStyle: null,
                            wrap: false,
                            border: theme.brightness == Brightness.light,
                          ),
                          widget.child
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
