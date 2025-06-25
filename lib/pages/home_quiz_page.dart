import 'package:app/pages/quiz_editor_page.dart';
import 'package:app/pages/quiz_page.dart';
import 'package:app/tiles/quiz_tile.dart';
import 'package:app/util/common_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeQuizPage extends StatefulWidget {
  const HomeQuizPage({super.key});
  @override
  State<HomeQuizPage> createState() => _HomeQuizPageState();
}

class _HomeQuizPageState extends State<HomeQuizPage> {
  final quizNameController = TextEditingController();
  final quizDescriptionController = TextEditingController();
  Color selectedColor = Colors.white;
  String searchQuery = '';

  @override
  void dispose() {
    quizNameController.dispose();
    quizDescriptionController.dispose();
    super.dispose();
  }

  Future<void> uploadQuizToDb() async {
    try {
      await FirebaseFirestore.instance.collection("quizzes").add({
        "creator": FirebaseAuth.instance.currentUser!.uid,
        "name": quizNameController.text.trim(),
        "description": quizDescriptionController.text.trim(),
        "color": rgbToHex(selectedColor),
        "reviewEnabled": true
      });
      quizNameController.clear();
      quizDescriptionController.clear();
      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }
  }

  void createQuiz() async {
    quizNameController.clear();
    quizDescriptionController.clear();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QuizEditorPage(
                  controller: quizNameController,
                  controllerd: quizDescriptionController,
                  onColorSelected: (Color color) {
                    selectedColor = color;
                  },
                  onSalva: uploadQuizToDb,
                  onAnnulla: () => Navigator.of(context).pop(),
                )));
  }

  void openQuiz(QueryDocumentSnapshot<Map<String, dynamic>> quiz) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QuizPage(
                  quiz: quiz,
                )));
  }

  void modifyQuiz(
      QueryDocumentSnapshot<Map<String, dynamic>> quizToModify) async {
    Navigator.pop(context);
    selectedColor = hexToColor(quizToModify.data()[
        'color']); //così che se non viene modificato il colore rimane il precedente
    quizNameController.text = quizToModify.data()['name'];
    quizDescriptionController.text = quizToModify.data()['description'];
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QuizEditorPage(
                controller: quizNameController,
                controllerd: quizDescriptionController,
                onColorSelected: (Color color) {
                  selectedColor = color;
                },
                onSalva: () async {
                  await FirebaseFirestore.instance
                      .collection("quizzes")
                      .doc(quizToModify.id)
                      .update({
                    'name': quizNameController.text,
                    'description': quizDescriptionController.text,
                    'color': rgbToHex(selectedColor)
                  });
                  setState(() {
                    Navigator.of(context).pop();
                  });
                },
                onAnnulla: (() => Navigator.of(context).pop()))));
  }

  void deleteQuiz(String quizToDeleteId) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Conferma eliminazione'),
          content: const Text(
              'Sei sicuro di voler eliminare questo quiz? Eliminerai tutti le flashcard ad esso associate'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annulla'),
            ),
            TextButton(
              onPressed: () async {
                FirebaseFirestore.instance
                    .collection("quizzes")
                    .doc(quizToDeleteId)
                    .delete();
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
              child: const Text('Elimina', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Future<int> getFlashcardsCount(String quizId) async {
    QuerySnapshot flashcardsSnapshot = await FirebaseFirestore.instance
        .collection('quizzes')
        .doc(quizId)
        .collection('flashcards')
        .get();

    return flashcardsSnapshot.size; // Numero di flashcard
  }

  void _searchQuiz(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            'I TUOI QUIZ',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                //decoration: TextDecoration.underline,
                decorationThickness: 1),
          ),
          Container(
            height: 100,
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.grey[200]),
                    child: TextField(
                      onChanged: _searchQuiz,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 20),
                          hintText: "Cerca"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("quizzes")
                  .where('creator',
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Text("Non ci sono ancora quiz");
                }

                final filteredQuizzes = snapshot.data!.docs.where((quiz) {
                  return quiz['name']
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase());
                }).toList();

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    padding: EdgeInsets.only(bottom: 80),
                    itemCount: filteredQuizzes.length,
                    itemBuilder: (context, index) {
                      var quizDoc = filteredQuizzes[index];

                      return FutureBuilder<int>(
                        future: getFlashcardsCount(quizDoc.id),
                        builder: (context, countSnapshot) {
                          return QuizTile(
                            quizName: quizDoc.data()['name'],
                            flashcardsCount: countSnapshot.data ?? 0,
                            color: hexToColor(quizDoc.data()['color']),
                            onOpenTile: () => openQuiz(quizDoc),
                            onOpenModifica: () => modifyQuiz(quizDoc),
                            onOpenElimina: () => deleteQuiz(quizDoc.id),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: '1',
        onPressed: () {
          createQuiz();
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
