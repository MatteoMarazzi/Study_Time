import 'package:flutter/material.dart';

class MyButtons extends StatelessWidget {
  final String name;
  VoidCallback onPressed;
  MyButtons({
    super.key,
    required this.name,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(name),
    );
  }
}