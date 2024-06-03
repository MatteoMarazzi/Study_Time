// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:app/UI/util/buttons.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddQuestionBox extends StatelessWidget {
  final questionController;
  final answerController;
  VoidCallback onSalva;
  VoidCallback onAnnulla;

  AddQuestionBox(
      {super.key,
      required this.questionController,
      required this.answerController,
      required this.onSalva,
      required this.onAnnulla});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 200,
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: TextField(
                  controller: questionController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "testo domanda",
                      hintStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      )),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: TextField(
                  controller: answerController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "risposta",
                      hintStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      )),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyButtons(name: 'Salva', onPressed: onSalva),
                MyButtons(name: 'Annulla', onPressed: onAnnulla)
              ],
            )
          ],
        ),
      ),
    );
  }
}
