import 'package:app/UI/pages/quiz_editor_page.dart';
import 'package:app/domain/quiz.dart';
import 'package:app/UI/pages/quiz_page.dart';
import 'package:app/UI/tiles/quiz_tile.dart';
import 'package:app/domain/utente.dart';
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
              Icons.arrow_back,
              color: Colors.black,
            )),
        centerTitle: true,
        title: const Text('QUIZ',
            textAlign: TextAlign.left, style: TextStyle(color: Colors.black)),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("quizzes")
            .where('creator', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {
            return Text("Non ci sono ancora quiz");
          }
          return ListView.builder(
            padding: EdgeInsets.only(bottom: 80),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return QuizTile(
                quizName: snapshot.data!.docs[index].data()['name'],
                flashcardsCount: 1,
                color: hexToColor(snapshot.data!.docs[index].data()['color']),
                onOpenTile: () => openQuiz(snapshot.data!.docs[index]),
                onOpenModifica: () => modifyQuiz(snapshot.data!.docs[index]),
                onOpenElimina: () => deleteQuiz(snapshot.data!.docs[index].id),
              );
            },
          );
        },
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
