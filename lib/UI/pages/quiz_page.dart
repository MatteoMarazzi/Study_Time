import 'package:app/databases/QuizDB.dart';
import 'package:app/domain/question.dart';
import 'package:app/domain/quiz.dart';
import 'package:app/UI/tiles/question_tile.dart';
import 'package:app/UI/util/add_question_box.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class QuizPage extends StatefulWidget {
  QuizPage({super.key, required this.title, required this.quiz});

  final String title;
  Quiz quiz;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final questionTextController = TextEditingController();
  final answerTextController = TextEditingController();
  //List<Question>? questionsList;

  void saveQuestion() async {
    widget.quiz.addQuestion(Question(
      text: questionTextController.text,
      answer: answerTextController.text,
    ));
    QuizzesDatabase().getAllQuestions(widget.quiz);
    questionTextController.clear();
    answerTextController.clear();
    setState(() {});
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  void createQuestion() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AddQuestionBox(
            questionController: questionTextController,
            answerController: answerTextController,
            OnSalva: saveQuestion,
            OnAnnulla: () => Navigator.of(context).pop(),
          );
        });
  }

  deleteQuestion(Question questionToDelete) {
    widget.quiz.deleteQuestion(questionToDelete);
    QuizzesDatabase().getAllQuestions(widget.quiz);
    setState(() {});
  }

  modifyQuestion(Question questionToModify) async {
    questionTextController.text = questionToModify.text;
    answerTextController.text = questionToModify.answer;
    await showDialog(
        context: context,
        builder: (context) {
          return AddQuestionBox(
              questionController: questionTextController,
              answerController: answerTextController,
              OnSalva: () async {
                /*await*/ widget.quiz.updateQuestion(
                    questionTextController.text,
                    answerTextController.text,
                    questionToModify);
                questionTextController.clear();
                answerTextController.clear();
                QuizzesDatabase().getAllQuestions(widget.quiz);
                setState(() {
                  Navigator.of(context).pop();
                });
              },
              OnAnnulla: (() => Navigator.of(context).pop()));
        });
  }

  openQuestion(int index) {}

  startQuiz() {}

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
        itemCount: widget.quiz.questions.length,
        itemBuilder: (context, index) {
          Question? currentQuestion = widget.quiz.getQuestion(index);
          return QuestionTile(
            questionText: currentQuestion!.getText(),
            answer: currentQuestion.getAnswer(),
            OnOpenTile: () => openQuestion(index),
            OnOpenElimina: () => deleteQuestion(currentQuestion),
            OnOpenModifica: () => modifyQuestion(currentQuestion),
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
