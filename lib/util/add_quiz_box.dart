// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flex_color_picker/flex_color_picker.dart'; //aggiunta palette cromatica
import 'package:app/util/buttons.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddQuizBox extends StatefulWidget {
  final controller;
  final controllerd;
  final ValueSetter<Color> onColorSelected;
  VoidCallback OnSalva;
  VoidCallback OnAnnulla;

  AddQuizBox(
      {super.key,
      required this.controller,
      required this.controllerd,
      required this.onColorSelected,
      required this.OnSalva,
      required this.OnAnnulla});

  @override
  State<AddQuizBox> createState() => _AddQuizBoxState();
}

class _AddQuizBoxState extends State<AddQuizBox> {
  Color chosenColor = Colors.red;
  double radius = 17;
  dynamic colorC = Color.fromARGB(255, 0, 0, 0);

  Widget buildColorPicker() => ColorPicker(
          color: colorC,
          onColorChanged: (value) {
            setState(() {
              colorC = value;
            });
            widget.onColorSelected(value);
          },
          spacing: 13.6,
          hasBorder: true,
          borderColor: Colors.black,
          borderRadius: 23,
          enableShadesSelection: false,
          pickersEnabled: const <ColorPickerType, bool>{
            ColorPickerType.both: false,
            ColorPickerType.primary: true,
            ColorPickerType.accent: false,
            ColorPickerType.bw: false,
            ColorPickerType.custom: false,
            ColorPickerType.wheel: false
          });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        content: Container(
          /*EdgeInsets.only(
                left: screenSize.width * 0.04,
                right: screenSize.width * 0.04,
                top: screenSize.height * 0.06), */
          width: 300,
<<<<<<< Updated upstream
          height: 438,
=======
          height: 700, //originale 450
>>>>>>> Stashed changes
          child: Column(
            children: [
              TextField(
                //si può mettere una max lenght
                controller: widget.controller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Nome quiz",
                    hintStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: widget.controllerd,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Descrizione",
                    hintStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Scegli il colore :",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Container(child: buildColorPicker()),
              Spacer(),
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
      ),
    );
  }
}
