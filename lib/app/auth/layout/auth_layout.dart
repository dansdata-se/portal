import "package:flutter/material.dart";
import "package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart";
import "package:portal/app/auth/layout/auth_layout_view_model.dart";
import "package:portal/app/auth/layout/background.dart";
import "package:portal/app/auth/layout/large_layout.dart";
import "package:portal/app/auth/layout/small_layout.dart";
import "package:portal/app/theme/paddings.dart";
import "package:provider/provider.dart";

class AuthLayout extends StatefulWidget {
  const AuthLayout({super.key, required this.child});

  final Widget child;

  @override
  State<StatefulWidget> createState() => _AuthLayoutState();
}

class _AuthLayoutState extends State<AuthLayout> {
  final _viewModel = AuthLayoutViewModel();

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Builder(
        builder: (context) => Scaffold(
          backgroundColor: theme.colorScheme.background,
          appBar: context.watch<AuthLayoutViewModel>().appBar,
          body: GestureDetector(
            // Remove focus when clicking outside text fields
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Stack(
              children: [
                const Background(),
                SlotLayout(
                  config: {
                    Breakpoints.small: SlotLayout.from(
                      key: const Key("authLayout.small"),
                      builder: (context) => SmallLayout(child: widget.child),
                    ),
                    Breakpoints.mediumAndUp: SlotLayout.from(
                      key: const Key("authLayout.large"),
                      builder: (context) => LargeLayout(child: widget.child),
                    ),
                  },
                )
              ],
            ),
          ),
          floatingActionButton: Wrap(
            alignment: WrapAlignment.end,
            direction: Axis.vertical,
            spacing: Paddings.large,
            children: context.watch<AuthLayoutViewModel>().fabs,
          ),
        ),
      ),
    );
  }
}
