import 'package:app/objects/question.dart';
import 'package:app/util/add_question_box.dart';
import 'package:app/tiles/quiz_tile.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  QuizPage({super.key, required this.title});

  final String title;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final _controller = TextEditingController();

  List<Question> domande = [];

  void saveQuestion() async {
    setState(() {
      domande.add(Question(text: _controller.text));
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  void createQuestion() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AddQuestionBox(
            controller: _controller,
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
        itemCount: domande.length,
        itemBuilder: (context, index) {
          return Tile(
            quizName: domande[index].text,
            quizDescription: 'campo da eliminare nelle domande',
            color: Colors.red,
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
