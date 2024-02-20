import 'package:app/objects/question.dart';
import 'package:app/objects/quiz.dart';
import 'package:app/util/question_tile.dart';
import 'package:app/util/add_question_box.dart';
import 'package:app/util/quiz_tile.dart';
import 'package:app/util/questionsDB.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  QuizPage({super.key, required this.title, required this.quiz});

  final String title;
  Quiz quiz;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final questionTextController = TextEditingController();

  void saveQuestion() async {
    await QuestionsDatabase().insertQuestion(Question(
      idQuiz: widget.quiz.id,
      text: questionTextController.text,
    ));
    await QuestionsDatabase().getAllQuestions(widget.quiz);
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
    List<Question>? questions = quiz2Questions[widget.quiz.id];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(2, 67, 69, 1),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8), //contorno intera lista
        itemCount: quiz2Questions[widget.quiz.id]!.length,
        itemBuilder: (context, index) {
          return QuestionTile(
            questionName: questions![index].text,
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
