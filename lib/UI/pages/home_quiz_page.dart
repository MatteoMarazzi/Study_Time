import 'package:app/UI/pages/quiz_editor_page.dart';
import 'package:app/domain/quiz.dart';
import 'package:app/UI/pages/quiz_page.dart';
import 'package:app/UI/tiles/quiz_tile.dart';
import 'package:app/domain/utente.dart';
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

  void saveQuiz() async {
    await Utente().addQuiz(
        name: quizNameController.text,
        description: quizDescriptionController.text,
        color: selectedColor);
    setState(() {});
    quizNameController.clear();
    quizDescriptionController.clear();
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  void createQuiz() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QuizEditorPage(
                  controller: quizNameController,
                  controllerd: quizDescriptionController,
                  onColorSelected: (Color color) {
                    selectedColor = color;
                  },
                  onSalva: saveQuiz,
                  onAnnulla: () => Navigator.of(context).pop(),
                )));
  }

  void openQuiz(Quiz quiz) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QuizPage(
                  title: quiz.name,
                  quiz: quiz,
                )));
  }

  void modifyQuiz(Quiz quiz) async {
    Navigator.pop(context);
    selectedColor = quiz
        .color; //così che se non viene modificato il colore rimane il precedente
    quizNameController.text = quiz.name;
    quizDescriptionController.text = quiz.description;
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
                  await Utente().updateQuiz(quizNameController.text,
                      quizDescriptionController.text, selectedColor, quiz);
                  quizNameController.clear();
                  quizDescriptionController.clear();
                  setState(() {
                    Navigator.of(context).pop();
                  });
                },
                onAnnulla: (() => Navigator.of(context).pop()))));
  }

  void deleteQuiz(Quiz quiz) async {
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
                await Utente().deleteQuiz(quiz);
                setState(() {});
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
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text('QUIZ',
            textAlign: TextAlign.left, style: TextStyle(color: Colors.black)),
      ),
      body: ListView.builder(
        itemCount: Utente().countQuizzes(),
        itemBuilder: (context, index) {
          Quiz? currentQuiz = Utente().getQuiz(index);
          return QuizTile(
            quizName: currentQuiz!.name,
            flashcardsCount: currentQuiz.questionsList.length,
            color: currentQuiz.color,
            onOpenTile: () => openQuiz(currentQuiz),
            onOpenModifica: () => modifyQuiz(currentQuiz),
            onOpenElimina: () => deleteQuiz(currentQuiz),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: '1',
        onPressed: () {
          createQuiz();
        },
        backgroundColor: const Color.fromARGB(255, 8, 73, 108),
        child: const Icon(Icons.add),
      ),
    );
  }
}
