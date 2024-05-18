import 'package:app/domain/exam.dart';
import 'package:app/domain/quiz.dart';
import 'package:app/UI/pages/quiz_page.dart';
import 'package:app/UI/util/add_quiz_box.dart';
import 'package:app/databases/questionsDB.dart';
import 'package:app/databases/quizDB.dart';
import 'package:app/UI/tiles/quiz_tile.dart';
import 'package:flutter/material.dart';

class HomeQuizPage extends StatefulWidget {
  const HomeQuizPage({super.key, required this.exam});
  final Exam exam;
  @override
  State<HomeQuizPage> createState() => _HomeQuizPageState();
}

class _HomeQuizPageState extends State<HomeQuizPage> {
  final quizNameController = TextEditingController();
  final quizDescriptionController = TextEditingController();
  Color selectedColor = Colors.black;

  void saveQuiz() async {
    await QuizzesDatabase().insertQuiz(Quiz(
        name: quizNameController.text,
        description: quizDescriptionController.text,
        color: selectedColor));
    await QuizzesDatabase().getAllQuizzes();
    quizNameController.clear();
    quizDescriptionController.clear();
    setState(() {});
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
            OnSalva: saveQuiz,
            OnAnnulla: () => Navigator.of(context).pop(),
          );
        });
  }

  void openQuiz(Quiz quiz) async {
    QuestionsDatabase().getAllQuestions(quiz);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QuizPage(
                  title: quiz.name,
                  quiz: quiz,
                )));
  }

  void modifyQuiz(Quiz quiz) async {
    quizNameController.text = quiz.getName();
    quizDescriptionController.text = quiz.getDescription();
    await showDialog(
        context: context,
        builder: (context) {
          return AddQuizBox(
              controller: quizNameController,
              controllerd: quizDescriptionController,
              onColorSelected: (Color color) {
                selectedColor = color;
              },
              OnSalva: () async {
                await QuizzesDatabase().updateQuiz(quizNameController.text,
                    quizDescriptionController.text, selectedColor, quiz);
                quizNameController.clear();
                quizDescriptionController.clear();
                await QuizzesDatabase().getAllQuizzes();
                setState(() {
                  Navigator.of(context).pop();
                });
              },
              OnAnnulla: (() => Navigator.of(context).pop()));
        });
  }

  void deleteQuiz(Quiz quiz) async {
    await QuizzesDatabase().deleteQuiz(quiz);
    await QuizzesDatabase().getAllQuizzes();
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
        itemCount: widget.exam.countQuizzes(),
        itemBuilder: (context, index) {
          Quiz? quiz = widget.exam.getQuiz(index);
          return QuizTile(
            quizName: quiz!.getName(),
            quizDescription: quiz!.getDescription(),
            color: quiz!.getColor(),
            OnOpenTile: () => openQuiz(quiz),
            OnOpenModifica: () => modifyQuiz(quiz),
            OnOpenElimina: () => deleteQuiz(quiz),
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
