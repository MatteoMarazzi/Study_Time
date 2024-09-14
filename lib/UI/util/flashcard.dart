import 'package:flutter/material.dart';

class Flashcard extends StatelessWidget {
  final String text;
  const Flashcard({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
