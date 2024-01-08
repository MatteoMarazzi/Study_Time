import 'package:app/util/Domanda.dart';
import 'package:app/util/add_question_box.dart';
import 'package:app/util/tile.dart';
import 'package:flutter/material.dart';


class QuizPage extends StatefulWidget {
  QuizPage({super.key, required String title});
  final String title;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage>{
  final _controller = TextEditingController();

  List<Domanda> domande = [];

  void saveQuestion() async{
    setState(() {
        domande.add(Domanda(_controller.text));
        _controller.clear();
      });
    Navigator.of(context).pop();
    }   

  void createQuestion() async{
    await showDialog(
      context: context,
      builder: (context){
        return AddQuestionBox(
          controller: _controller,
          OnSalva: saveQuestion,
          OnAnnulla: () => Navigator.of(context).pop(),
        );
      });
  } 

  openQuestion(int index) {}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style : TextStyle(
          color: Colors.white,
          )
          ),
        backgroundColor: const Color.fromRGBO(2, 67, 69, 1),
      ),
      body: ListView.builder(
        itemCount: domande.length,
        itemBuilder: (context, index){
          return Tile(
            quizName: domande[index].testo,
            OnOpenTile: () => openQuestion(index)
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