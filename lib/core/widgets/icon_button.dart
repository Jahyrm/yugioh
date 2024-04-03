import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({super.key, this.onPressed, required this.icon});

  final void Function()? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: IconButton.styleFrom(
        side: const BorderSide(color: Colors.grey),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        shadowColor: Colors.black.withOpacity(0.3),
      ),
      onPressed: onPressed,
      icon: icon,
    );
  }
}
