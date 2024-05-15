import 'package:app/domain/quiz.dart';
import 'package:app/UI/pages/quiz_page.dart';
import 'package:app/UI/util/add_quiz_box.dart';
import 'package:app/databases/questionsDB.dart';
import 'package:app/databases/quizDB.dart';
import 'package:app/UI/tiles/quiz_tile.dart';
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
    QuestionsDatabase().getAllQuestions(quiz);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QuizPage(
                  title: quiz.name,
                  quiz: quiz,
                )));
  }

  void modifyQuiz(int index) async {
    quizNameController.text = quizzesDataList[index].name;
    quizDescriptionController.text = quizzesDataList[index].description;
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
                    quizzesDataList[index]);
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
    await QuizzesDatabase().deleteQuiz(quizzesDataList[index]);
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
        itemCount: quizzesDataList.length,
        itemBuilder: (context, index) {
          return QuizTile(
            quizName: quizzesDataList[index].name,
            quizDescription: quizzesDataList[index].description,
            color: quizzesDataList[index].color,
            OnOpenTile: () => openQuiz(quizzesDataList[index]),
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
