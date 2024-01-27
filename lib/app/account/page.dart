import "package:dansdata_portal/app/account/view_model.dart";
import "package:dansdata_portal/app/view_model/widget.dart";
import "package:dansdata_portal/dependency_injection/inject.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:signals/signals_flutter.dart";

class AccountPage extends ViewModelWidget<AccountViewModel> {
  const AccountPage({super.key});

  @override
  AccountViewModel createViewModel(context) =>
      AccountViewModel(appContext: context.inject());

  @override
  Widget build(BuildContext context, AccountViewModel viewModel) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Account Page",
            style: theme.textTheme.displayLarge,
          ),
          FilledButton(
            onPressed: () => viewModel.gotoDashboard(),
            child: Text(watchSignal(context, viewModel.buttonText)),
          ),
        ],
      ),
    );
  }

  static final GoRoute route = GoRoute(
    path: "/account",
    pageBuilder: (context, state) => NoTransitionPage(
      key: state.pageKey,
      child: const AccountPage(),
    ),
  );
}
