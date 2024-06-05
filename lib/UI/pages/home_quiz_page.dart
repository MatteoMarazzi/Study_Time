import 'package:app/domain/quiz.dart';
import 'package:app/UI/pages/quiz_page.dart';
import 'package:app/UI/util/add_quiz_box.dart';
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
  Color selectedColor = Colors.black;

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
    await showDialog(
        context: context,
        builder: (context) {
          return AddQuizBox(
            controller: quizNameController,
            controllerd: quizDescriptionController,
            onColorSelected: (Color color) {
              selectedColor = color;
            },
            onSalva: saveQuiz,
            onAnnulla: () => Navigator.of(context).pop(),
          );
        });
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
    quizNameController.text = quiz.name;
    quizDescriptionController.text = quiz.description;
    await showDialog(
        context: context,
        builder: (context) {
          return AddQuizBox(
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
              onAnnulla: (() => Navigator.of(context).pop()));
        });
  }

  void deleteQuiz(Quiz quiz) async {
    Utente().deleteQuiz(quiz);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(2, 67, 69, 1),
        centerTitle: true,
        title: const Text('QUIZ',
            textAlign: TextAlign.left, style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        itemCount: Utente().countQuizzes(),
        itemBuilder: (context, index) {
          Quiz? currentQuiz = Utente().getQuiz(index);
          return QuizTile(
            quizName: currentQuiz!.name,
            quizDescription: currentQuiz.description,
            color: currentQuiz.color,
            onOpenTile: () => openQuiz(currentQuiz),
            onOpenModifica: () => modifyQuiz(currentQuiz),
            onOpenElimina: () => deleteQuiz(currentQuiz),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createQuiz();
        },
        backgroundColor: const Color.fromARGB(255, 8, 73, 108),
        child: const Icon(Icons.add),
      ),
    );
  }
}
