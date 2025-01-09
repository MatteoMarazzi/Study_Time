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
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Text(widget.title, style: const TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Due riquadri per riga
          crossAxisSpacing: 10, // Spazio orizzontale tra i riquadri
          mainAxisSpacing: 8, // Spazio verticale tra i riquadri
          childAspectRatio: 2 / 3, // Rapporto larghezza/altezza per i riquadri
        ),
        padding: const EdgeInsets.all(8), //contorno intera lista
        itemCount: widget.quiz.questionsList.length,
        itemBuilder: (context, index) {
          Question? currentQuestion = widget.quiz.questionsList[index];
          return QuestionTile(
            questionText: currentQuestion.text,
            color: widget.quiz.color,
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
              backgroundColor: const Color.fromARGB(255, 8, 73, 108),
              child: const Icon(Icons.add),
            ),
            const SizedBox(width: 16),
            FloatingActionButton(
              heroTag: '3',
              onPressed: widget.quiz.questionsList.isEmpty ? null : startQuiz,
              backgroundColor: widget.quiz.questionsList.isEmpty
                  ? Colors.grey
                  : const Color.fromARGB(255, 8, 73, 108),
              child: const Icon(Icons.play_arrow),
            ),
          ],
        ),
      ),
    );
  }
}
