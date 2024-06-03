import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyButtons extends StatelessWidget {
  final String name;
  VoidCallback onPressed;
  MyButtons({super.key, required this.name, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          )),
    );
  }
}
