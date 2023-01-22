import "package:flutter/material.dart";
import "package:portal/app/auth/layout/auth_layout_view_model.dart";
import "package:portal/app/routing/portal_app_bar.dart";
import "package:provider/provider.dart";

class SmallLayout extends StatefulWidget {
  const SmallLayout({super.key, required this.child});

  final Widget child;

  @override
  State<StatefulWidget> createState() => _SmallLayoutState();
}

class _SmallLayoutState extends State<SmallLayout> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final viewModel = Provider.of<AuthLayoutViewModel>(context, listen: false);
    final appBar = PortalAppBar.of(context);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.updateAppBar(appBar);
    });
  }

  @override
  void deactivate() {
    final viewModel = Provider.of<AuthLayoutViewModel>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!viewModel.isDisposed) {
        viewModel.clearAppBar();
      }
    });

    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        // Make background more opaque to improve readability
        Container(
          color: theme.colorScheme.background.withAlpha(200),
        ),
        LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: widget.child,
            ),
          ),
        ),
      ],
    );
  }
}
