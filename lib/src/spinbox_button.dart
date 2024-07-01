import 'package:flutter/material.dart';

/// {@template duration_spinbox.SpinboxButton}
/// Custom button for duration_spinbox
/// {@endtemplate}
///
///
class SpinboxButton extends StatelessWidget {
  /// {@macro duration_spinbox.SpinboxButton}
  const SpinboxButton({
    required this.icon,
    super.key,
    this.onPressed,
  });

  /// Action to be executed when this [SpinboxButton] is pressed.
  final void Function()? onPressed;

  /// Icon to display in this button
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return IconButton(
      onPressed: onPressed,
      disabledColor: colorScheme.outline,
      color: colorScheme.primary,
      icon: icon,
    );
  }
}
