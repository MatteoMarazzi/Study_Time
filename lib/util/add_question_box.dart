import 'package:app/util/buttons.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddQuestionBox extends StatelessWidget {
  final controller;
  VoidCallback OnSalva;
  VoidCallback OnAnnulla;
  AddQuestionBox(
      {super.key,
      required this.controller,
      required this.OnSalva,
      required this.OnAnnulla});

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
                hintText: "Testo domanda",
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
