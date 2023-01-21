import "package:flutter/widgets.dart";
import "package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart";

extension WhenActive on Breakpoint {
  T? whenActive<T>(BuildContext context, T? t) => isActive(context) ? t : null;
}
