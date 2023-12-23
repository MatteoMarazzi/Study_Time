// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:app/util/buttons.dart';
import 'package:flutter/material.dart';

class DialogueBox extends StatelessWidget {
  final controller;
  VoidCallback OnSalva;
  VoidCallback OnAnnulla;

  DialogueBox({super.key,required this.controller,required this.OnSalva,required this.OnAnnulla});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 200,
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Scrivi la domanda",
              ),
            ),
            Row(
              children: [
                MyButtons(name: 'Salva', onPressed: OnSalva),

                MyButtons(name: 'Annulla', onPressed: OnAnnulla)
              ],
            )
          ],
        ),
      ),
    );
  }
}