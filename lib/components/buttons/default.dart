import 'package:flut_todo/extensions/space_exs.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;
  final IconData? icon;
  final String? type;
  final VoidCallback onTap;

  const Button({
    super.key,
    required this.title,
    this.icon,
    this.type,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Define colors based on the button type
    Color backgroundColor;
    Color textColor;

    if (type == 'primary') {
      backgroundColor = Colors.indigo;
      textColor = Colors.white;
    } else {
      // secondary
      backgroundColor = Colors.white;
      textColor = Colors.indigo;
    }

    return MaterialButton(
      onPressed: onTap,
      minWidth: 80,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      height: 40,
      child: Row(
        mainAxisSize: MainAxisSize.min, // Adjust Row size based on content
        children: [
          if (icon != null) ...[
            Icon(icon, color: textColor),
            5.w, // Spacing between icon and text
          ],
          Text(
            title,
            style: TextStyle(color: textColor),
          ),
        ],
      ),
    );
  }
}
