import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.fullWidth = true,
    this.outlined = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool fullWidth;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    final text = Text(
      label,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
    );

    final child = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
      children: [
        if (icon != null) ...[Icon(icon, size: 19), const SizedBox(width: 8)],
        if (fullWidth) Flexible(child: text) else text,
      ],
    );

    final button = outlined
        ? OutlinedButton(onPressed: onPressed, child: child)
        : FilledButton(onPressed: onPressed, child: child);

    if (!fullWidth) {
      return button;
    }

    return SizedBox(width: double.infinity, child: button);
  }
}
