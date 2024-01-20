import "package:dansdata_portal/app/dashboard/viewmodel.dart";
import "package:dansdata_portal/app/view_model/widget.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

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
            child: const Text("Account"),
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
