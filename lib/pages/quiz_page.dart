import 'package:app/objects/question.dart';
import 'package:app/tiles/question_tile.dart';
import 'package:app/util/add_question_box.dart';
import 'package:app/tiles/quiz_tile.dart';
import 'package:app/databases/questionsDB.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  QuizPage({super.key, required this.title});

  final String title;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final questionTextController = TextEditingController();

  void saveQuestion() async {
    await QuestionsDatabase().insertQuestion(Question(
      text: questionTextController.text,
    ));
    await QuestionsDatabase().getAllQuestions();
    questionTextController.clear();
    setState(() {});
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  void createQuestion() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AddQuestionBox(
            controller: questionTextController,
            OnSalva: saveQuestion,
            OnAnnulla: () => Navigator.of(context).pop(),
          );
        });
  }

  deleteQuestion(int index) {}

  modifyQuestion(int index) {}

  openQuestion(int index) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(2, 67, 69, 1),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8), //contorno intera lista
        itemCount: QuestionsDataList.length,
        itemBuilder: (context, index) {
          return QuestionTile(
            questionName: QuestionsDataList[index].text,
            OnOpenTile: () => openQuestion(index),
            OnOpenElimina: () => deleteQuestion(index),
            OnOpenModifica: () => modifyQuestion(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createQuestion,
        child: Icon(Icons.add),
      ),
    );
  }
}
