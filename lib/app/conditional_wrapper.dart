import "package:flutter/material.dart";

/// A [Widget] that wraps the given [child] using [wrapper] if [shouldWrap] is true.
class ConditionalWrapper extends StatelessWidget {
  const ConditionalWrapper({
    super.key,
    required this.shouldWrap,
    required this.wrapper,
    required this.child,
  });

  final bool shouldWrap;
  final Widget Function(Widget) wrapper;
  final Widget child;

  @override
  Widget build(BuildContext context) => shouldWrap ? wrapper(child) : child;
}
