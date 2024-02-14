import 'package:flutter/material.dart';

class bar_Button extends StatelessWidget {
  final Color color;
  final IconData icon;

  const bar_Button({super.key, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      onPressed: () {},
      color: Colors.white,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    );
  }
}
