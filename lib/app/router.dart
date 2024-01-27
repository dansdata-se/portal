import "package:dansdata_portal/app/account/page.dart";
import "package:dansdata_portal/app/conditional_wrapper.dart";
import "package:dansdata_portal/app/context.dart";
import "package:dansdata_portal/app/dashboard/page.dart";
import "package:dansdata_portal/dependency_injection/inject.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:signals/signals_flutter.dart";

final mainRouter = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) => ConditionalWrapper(
        shouldWrap: kIsWeb,
        wrapper: (child) => SelectionArea(child: child),
        child: child,
      ),
      routes: [
        ShellRoute(
          builder: (context, state, child) => Scaffold(
            body: LayoutBuilder(
              builder: (context, constraints) {
                final appContext = context.inject<ApplicationContext>();
                batch(() {
                  appContext.contentWidth.value = constraints.maxWidth;
                  appContext.contentHeight.value = constraints.maxHeight;
                });
                return child;
              },
            ),
          ),
          routes: [
            DashboardPage.route,
            AccountPage.route,
          ],
        ),
      ],
    ),
  ],
);
