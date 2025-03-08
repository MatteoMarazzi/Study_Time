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
  //double radius = 17;
  bool isSaveButtonEnabled = false;
  dynamic selectedColor = Colors.transparent;
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_validateInputs);
    _validateInputs();
  }

  void _validateInputs() {
    if (mounted) {
      setState(() {
        isSaveButtonEnabled = widget.controller.text.isNotEmpty;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    bool showFab = MediaQuery.of(context).viewInsets.bottom != 0;
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
              child: SingleChildScrollView(
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
                      Center(
                        child: ColorPicker(
                          color: selectedColor,
                          onColorChanged: (Color color) {
                            setState(() {
                              selectedColor = color;
                            });
                            widget.onColorSelected(color);
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
                        ),
                      ),
                      Text('Descrizione', style: TextStyle(fontSize: 18)),
                      const SizedBox(
                        height: 8,
                      ),
                      TextField(
                          maxLines: 4,
                          minLines: 1,
                          maxLength: 80,
                          controller: widget.controllerd,
                          onChanged: (text) {
                            if (widget.controllerd.value.text
                                    .split('\n')
                                    .length >
                                4) {
                              widget.controllerd.text = widget
                                  .controllerd.value.text
                                  .split('\n')
                                  .sublist(0, 4)
                                  .join('\n');
                              widget.controllerd.selection =
                                  TextSelection.fromPosition(
                                TextPosition(
                                    offset: widget.controllerd.text.length),
                              );
                            }
                          },
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
            ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: !showFab,
        child: SizedBox(
          width: 400,
          child: Card(
            elevation: 5,
            shadowColor: Colors.black,
            color: isSaveButtonEnabled ? Colors.white : Colors.grey,
            child: TextButton(
              onPressed: isSaveButtonEnabled ? widget.onSalva : null,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
