import "package:flutter/material.dart";

/// A filled button with an optional loading state.
///
/// While in the loading state, the button will become disabled and display only
/// a circular progress indicator.
class FilledLoadingButton extends StatelessWidget {
  const FilledLoadingButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
    required this.child,
  });

  final Function() onPressed;
  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: theme.colorScheme.onPrimary,
        backgroundColor: theme.colorScheme.primary,
      ).copyWith(elevation: ButtonStyleButton.allOrNull(0)),
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? SizedBox.square(
              dimension: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: theme.colorScheme.onSurface.withOpacity(.38),
              ),
            )
          : child,
    );
  }
}
