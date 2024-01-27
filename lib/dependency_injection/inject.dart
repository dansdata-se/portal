import "package:dansdata_portal/dependency_injection/dependencies.dart";
import "package:flutter/widgets.dart";

extension DependencyInjection on BuildContext {
  T inject<T extends Object>() => Dependencies.of(this).get<T>();
}
