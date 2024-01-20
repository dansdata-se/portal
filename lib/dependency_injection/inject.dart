import "package:dansdata_portal/dependency_injection/dependencies.dart";
import "package:flutter/widgets.dart";

T inject<T extends Object>(BuildContext context) =>
    Dependencies.of(context).get<T>();
