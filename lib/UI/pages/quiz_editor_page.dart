import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class QuizEditorPage extends StatefulWidget {
  final controller;
  final controllerd;
  final ValueSetter<Color> onColorSelected;
  VoidCallback onSalva;
  VoidCallback onAnnulla;

  QuizEditorPage(
      {super.key,
      required this.controller,
      required this.controllerd,
      required this.onColorSelected,
      required this.onSalva,
      required this.onAnnulla});

  @override
  State<QuizEditorPage> createState() => _QuizEditorPageState();
}

class _QuizEditorPageState extends State<QuizEditorPage> {
  double radius = 17;
  dynamic selectedColor;
  Widget buildColorPicker() => ColorPicker(
        color: selectedColor = Colors.transparent,
        onColorChanged: (value) {
          setState(() {
            selectedColor = value;
          });
          widget.onColorSelected(value);
        },
        spacing: 20,
        hasBorder: true,
        borderColor: Colors.black,
        borderRadius: 20,
        enableShadesSelection: false,
        pickersEnabled: const <ColorPickerType, bool>{
          ColorPickerType.both: false,
          ColorPickerType.primary: false,
          ColorPickerType.accent: false,
          ColorPickerType.bw: false,
          ColorPickerType.custom: true,
        },
        customColorSwatchesAndNames: {
          Colors.red: 'Rosso',
          Colors.blue: 'Blu',
          Colors.green: 'Verde',
          Colors.orange: 'Arancione',
          Colors.purple: 'Viola',
          Colors.yellow: 'Giallo',
        },
      );

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          icon: const Icon(
            Icons.clear_rounded,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'QUIZ Editor',
          textAlign: TextAlign.left,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nome quiz',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      maxLength: 28,
                      controller: widget.controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Aggiungi il nome del quiz",
                        hintStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const Text(
                      "Scegli il colore:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    buildColorPicker(),
                    Text('Descrizione', style: TextStyle(fontSize: 18)),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                        maxLength: 80,
                        controller: widget.controllerd,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Aggiungi la descrzione",
                            hintStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(left: screenSize.width * 0.08),
          child: SizedBox(
            width: 400,
            child: Card(
              elevation: 5,
              color: Colors.white,
              shadowColor: Colors.black,
              child: TextButton(
                onPressed: widget.onSalva,
                style: ButtonStyle(
                  animationDuration: const Duration(seconds: 5),
                  overlayColor: MaterialStateProperty.all(Colors.grey),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Salva',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
