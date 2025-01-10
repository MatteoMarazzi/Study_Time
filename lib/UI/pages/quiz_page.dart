import 'package:app/UI/pages/questions_editor_page.dart';
import 'package:app/UI/pages/quiz_execution_page.dart';
import 'package:app/domain/question.dart';
import 'package:app/domain/quiz.dart';
import 'package:app/UI/tiles/question_tile.dart';
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
    setState(() {});
    questionTextController.clear();
    answerTextController.clear();
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  void createQuestion() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QuestionsEditorPage(
                  questionController: questionTextController,
                  answerController: answerTextController,
                  onSalva: saveQuestion,
                  onAnnulla: () => Navigator.of(context).pop(),
                )));
  }

  deleteQuestion(Question questionToDelete) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Conferma eliminazione'),
          content:
              const Text('Sei sicuro di voler eliminare questa flashcard?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annulla'),
            ),
            TextButton(
              onPressed: () async {
                widget.quiz.deleteQuestion(questionToDelete);
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

  modifyQuestion(Question questionToModify) async {
    questionTextController.text = questionToModify.text;
    answerTextController.text = questionToModify.answer;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QuestionsEditorPage(
                  questionController: questionTextController,
                  answerController: answerTextController,
                  onSalva: saveQuestion,
                  onAnnulla: () => Navigator.of(context).pop(),
                )));
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
