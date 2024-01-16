// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:app/util/buttons.dart';
import 'package:flutter/material.dart';

const Color k1CustomColor = Colors.black; //COLORI IMPOSTABILI PER I RIQUADRI
const Color k2CustomColor = Colors.red;
const Color k3CustomColor = Colors.blue;
const Color k4CustomColor = Colors.green;
const Color k5CustomColor = Colors.purple;
const Color k6CustomColor = Colors.yellow;
const Color k7CustomColor = Colors.grey;
const Color chosen = Colors.white;

// ignore: must_be_immutable
class AddQuizBox extends StatefulWidget {
  final controller;
  VoidCallback OnSalva;
  VoidCallback OnAnnulla;

  AddQuizBox(
      {super.key,
      required this.controller,
      required this.OnSalva,
      required this.OnAnnulla});

  @override
  State<AddQuizBox> createState() => _AddQuizBoxState();
}

class _AddQuizBoxState extends State<AddQuizBox> {
  Color chosenColor = Colors.red;
  double radius = 17;

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
                  controller: widget.controller,
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
            Row(children: [
              Spacer(),
              CircleWidget(
                radius: radius,
                color: k2CustomColor,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      radius = 20;
                      chosenColor = Color.fromARGB(
                          255, 54, 73, 244); // Modifica della variabile globale
                    });
                  },
                ),
              ),
              Spacer(),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyButtons(name: 'Salva', onPressed: widget.OnSalva),
                MyButtons(name: 'Annulla', onPressed: widget.OnAnnulla)
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CircleWidget extends StatelessWidget {
  final double radius;
  final Color color;
  final Widget child;

  const CircleWidget(
      {Key? key,
      required this.radius,
      required this.color,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.black),
        shape: BoxShape.circle,
        color: color, // Puoi personalizzare il colore del cerchio
      ),
    );
  }
}
