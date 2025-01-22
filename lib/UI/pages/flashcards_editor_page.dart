import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FlashcardsEditorPage extends StatefulWidget {
  final questionController;
  final answerController;
  VoidCallback onSalva;
  VoidCallback onAnnulla;

  FlashcardsEditorPage(
      {super.key,
      required this.questionController,
      required this.answerController,
      required this.onSalva,
      required this.onAnnulla});

  @override
  State<FlashcardsEditorPage> createState() => _FlashcardsEditorPageState();
}

class _FlashcardsEditorPageState extends State<FlashcardsEditorPage> {
  bool isSaveButtonEnabled = false;
  @override
  void initState() {
    super.initState();
    widget.questionController.addListener(_validateInputs);
    _validateInputs();
  }

  void _validateInputs() {
    if (mounted) {
      setState(() {
        isSaveButtonEnabled = widget.questionController.text.isNotEmpty;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
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
          'Questions Editor',
          textAlign: TextAlign.left,
          style: TextStyle(color: Colors.black),
        ),
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
                      Text(
                        'Domanda',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: widget.questionController,
                        maxLines: 3,
                        minLines: 3,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Aggiungi domanda",
                          hintStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                        'Risposta',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                          controller: widget.answerController,
                          maxLines: 3,
                          minLines: 3,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Aggiungi risposta",
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
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(left: screenSize.width * 0.08),
          child: SizedBox(
            width: 400,
            child: Card(
              elevation: 5,
              color: isSaveButtonEnabled ? Colors.white : Colors.grey,
              shadowColor: Colors.black,
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
      ),
    );
  }
}
