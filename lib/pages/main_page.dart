import 'package:app/util/add_quiz_box.dart';
import 'package:app/util/quiz_tile.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});
  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  List quiz = [];

  final _controller = TextEditingController();

  void saveQuiz() async{
    if(_controller.text!= Null){
       setState(() {
      quiz.add(_controller.text);
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

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: quiz.length,
        itemBuilder: (context, index){
          return QuizTile(
            quizName: quiz[index][0],
            OnOpenQuiz: () => openQuiz(index)
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createQuiz,
        child: const Icon(Icons.add),
      ),
    );
  }
}
