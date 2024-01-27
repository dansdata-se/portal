import "package:dansdata_portal/app/dashboard/view_model.dart";
import "package:dansdata_portal/app/view_model/widget.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:signals/signals_flutter.dart";

class DashboardPage extends ViewModelWidget<DashboardViewModel> {
  const DashboardPage({super.key});

  @override
  DashboardViewModel createViewModel(appContext) =>
      DashboardViewModel(appContext: appContext);

  @override
  Widget build(BuildContext context, DashboardViewModel viewModel) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Dashboard Page",
            style: theme.textTheme.displayLarge,
          ),
          FilledButton(
            onPressed: () => viewModel.gotoAccount(),
            child: Text(watchSignal(context, viewModel.buttonText)),
          ),
        ],
      ),
    );
  }

  static final GoRoute route = GoRoute(
    path: "/",
    pageBuilder: (context, state) => NoTransitionPage(
      key: state.pageKey,
      child: const DashboardPage(),
    ),
  );
}
