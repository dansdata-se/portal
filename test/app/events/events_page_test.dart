import "package:portal/app/events/events_page.dart";

import "../default_page_tests.dart";

void main() {
  defaultPageTests(
    const EventsDestination(),
    EventsPage.pageKey,
    (t) => t.labelEvents,
  );
}
