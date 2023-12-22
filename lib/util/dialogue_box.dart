// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:app/util/buttons.dart';
import 'package:flutter/material.dart';

class DialogueBox extends StatelessWidget {
  const DialogueBox({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 200,
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Scrivi la domanda",
              ),
            ),
            Row(
              children: [
                MyButtons(name: 'Salva', onPressed: () {}),
                MyButtons(name: 'Annulla', onPressed: () {})
              ],
            )
          ],
        ),
      ),
    );
  }
}