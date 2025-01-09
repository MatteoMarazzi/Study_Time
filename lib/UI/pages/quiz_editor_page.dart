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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(false); // Passing false as result
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
        actions: [
          IconButton(
            onPressed: widget.onSalva,
            icon: const Icon(
              Icons.check,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        maxLength: 28,
                        controller: widget.controller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Nome quiz",
                          hintStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Scegli il colore:",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      buildColorPicker(),
                      const SizedBox(height: 16.0),
                      TextField(
                          controller: widget.controllerd,
                          maxLines: null,
                          minLines: 1,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Descrizione",
                              hintStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ))),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
