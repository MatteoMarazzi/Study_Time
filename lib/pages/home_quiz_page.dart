import 'package:app/objects/quiz.dart';
import 'package:app/pages/quiz_page.dart';
import 'package:app/util/add_quiz_box.dart';
import 'package:app/databases/questionsDB.dart';
import 'package:app/databases/quizDB.dart';
import 'package:app/tiles/quiz_tile.dart';
import 'package:flutter/material.dart';

class HomeQuizPage extends StatefulWidget {
  const HomeQuizPage({
    super.key,
  });

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
    await QuestionsDatabase().getAllQuestions(quiz);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QuizPage(
                  title: quiz.name,
                  quiz: quiz,
                )));
  }

  void modifyQuiz(int index) async {
    quizNameController.text = QuizzesDataList[index].name;
    quizDescriptionController.text = QuizzesDataList[index].description;
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
                await QuizzesDatabase().updateQuiz(
                    quizNameController.text,
                    quizDescriptionController.text,
                    selectedColor,
                    QuizzesDataList[index]);
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

  void deleteQuiz(int index) async {
    await QuizzesDatabase().deleteQuiz(QuizzesDataList[index]);
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
        itemCount: QuizzesDataList.length,
        itemBuilder: (context, index) {
          return QuizTile(
            quizName: QuizzesDataList[index].name,
            quizDescription: QuizzesDataList[index].description,
            color: QuizzesDataList[index].color,
            OnOpenTile: () => openQuiz(QuizzesDataList[index]),
            OnOpenModifica: () => modifyQuiz(index),
            OnOpenElimina: () => deleteQuiz(index),
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
