import "package:portal/app/dashboard/dashboard_page.dart";

import "../default_page_tests.dart";

void main() {
  defaultPageTests(
    const DashboardDestination(),
    DashboardPage.pageKey,
    (t) => t.labelDashboard,
  );
}
