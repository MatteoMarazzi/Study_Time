import 'package:app/UI/pages/quiz_execution_page.dart';
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

  void saveQuestion() async {
    widget.quiz.addQuestion(
      text: questionTextController.text,
      answer: answerTextController.text,
    );
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
            onSalva: saveQuestion,
            onAnnulla: () => Navigator.of(context).pop(),
          );
        });
  }

  deleteQuestion(Question questionToDelete) {
    widget.quiz.deleteQuestion(questionToDelete);
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
              onSalva: () async {
                /*await*/ widget.quiz.updateQuestion(
                    questionTextController.text,
                    answerTextController.text,
                    questionToModify);
                questionTextController.clear();
                answerTextController.clear();
                setState(() {
                  Navigator.of(context).pop();
                });
              },
              onAnnulla: (() => Navigator.of(context).pop()));
        });
  }

  openQuestion(int index) {}

  startQuiz() async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QuizExecutionPage(
                  quiz: widget.quiz,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(2, 67, 69, 1),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8), //contorno intera lista
        itemCount: widget.quiz.questionsList.length,
        itemBuilder: (context, index) {
          Question? currentQuestion = widget.quiz.questionsList[index];
          return QuestionTile(
            questionText: currentQuestion.text,
            answer: currentQuestion.answer,
            onOpenTile: () => openQuestion(index),
            onOpenElimina: () => deleteQuestion(currentQuestion),
            onOpenModifica: () => modifyQuestion(currentQuestion),
          );
        },
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              heroTag: '2',
              onPressed: createQuestion,
              child: const Icon(Icons.add),
            ),
            const SizedBox(width: 16),
            FloatingActionButton(
              heroTag: '3',
              onPressed: startQuiz,
              child: const Icon(Icons.play_arrow),
            ),
          ],
        ),
      ),
    );
  }
}
