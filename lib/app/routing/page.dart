import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:portal/app/routing/destination.dart";
import "package:portal/app/state/page_title_state.dart";
import "package:provider/provider.dart";

void _applyPageTitle(BuildContext context, Destination destination) {
  unawaited(
    context
        .read<PageTitleState>()
        .update(destination.getLabel(AppLocalizations.of(context)!)),
  );
}

abstract class _Page {
  abstract final Destination destination;

  void applyPageTitle(BuildContext context) =>
      _applyPageTitle(context, destination);

  @mustCallSuper
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => applyPageTitle(context));
    return Container();
  }
}

abstract class StatelessPage extends StatelessWidget with _Page {
  const StatelessPage({super.key, required this.destination});

  @override
  final Destination destination;
}

abstract class StatefulPage extends StatefulWidget {
  const StatefulPage({super.key, required this.destination});

  final Destination destination;

  @override
  PageState<StatefulPage> createState();
}

abstract class PageState<T extends StatefulPage> extends State<T> with _Page {
  @override
  Destination get destination => widget.destination;
}
