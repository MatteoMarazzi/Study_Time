import 'package:app/pages/quiz_page.dart';
import 'package:app/util/Quiz.dart';
import 'package:app/util/add_quiz_box.dart';
import 'package:app/util/tile.dart';
import 'package:flutter/material.dart';

class HomeQuizPage extends StatefulWidget {
  const HomeQuizPage({super.key, required this.title});
  final String title;

  @override
  State<HomeQuizPage> createState() => _HomeQuizPageState();
}

class _HomeQuizPageState extends State<HomeQuizPage> {

  List <Quiz> quizzes = [];

  final _controller = TextEditingController();

  void saveQuiz() async{
    if(_controller.text!= Null){
       setState(() {
        quizzes.add(Quiz(_controller.text));
        _controller.clear();
      });
    }  
    Navigator.of(context).pop();
  }
  
  void createQuiz() async{
    await showDialog(
      context: context,
      builder: (context){
        return AddQuizBox(
          controller: _controller,
          OnSalva: saveQuiz,
          OnAnnulla: () => Navigator.of(context).pop(),
        );
      });
  }

  void openQuiz(int index) async{
    Navigator.push(
      context, MaterialPageRoute(
        builder: (context) => QuizPage(title: "DOMANDE")
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(2, 67, 69, 1)
,

        title: Text(
          textAlign: TextAlign.left,
            widget.title,
            style : TextStyle(color: Colors.white)
          ),
       ),
      body: ListView.builder(
        itemCount: quizzes.length,
        itemBuilder: (context, index){
          return Tile(
            quizName: quizzes[index].nome,
            OnOpenTile: () => openQuiz(index)
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createQuiz,
        child: const Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 8, 73, 108),
      ),
    );
  }
}