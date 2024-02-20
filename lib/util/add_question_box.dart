// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

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
            Expanded(
              child: Center(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Nome quiz",
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
