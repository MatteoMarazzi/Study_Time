import 'package:app/objects/quiz.dart';
import 'package:app/pages/quiz_page.dart';
import 'package:app/util/add_quiz_box.dart';
import 'package:app/util/quizDB.dart';
import 'package:app/util/tile.dart';
import 'package:flutter/material.dart';

class HomeQuizPage extends StatefulWidget {
  const HomeQuizPage({
    super.key,
  });

  @override
  State<HomeQuizPage> createState() => _HomeQuizPageState();
}

class _HomeQuizPageState extends State<HomeQuizPage> {
  //List<Quiz> quizzes = [];

  final _controller = TextEditingController();
  final _controllerd = TextEditingController();
  Color selectedColor = Colors.black;

  void saveQuiz() async {
    await LocalDataBase().insertQuiz(Quiz(
        name: _controller.text,
        description: _controllerd.text,
        color: selectedColor));
    await LocalDataBase().getAllQuizzes();
    _controller.clear();
    _controllerd.clear();
    setState(() {
      //quizzes.add(Quiz(nome: _controller.text, id: quizzes.length));
    });
    Navigator.of(context).pop();
  }

  void createQuiz() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AddQuizBox(
            controller: _controller,
            controllerd: _controllerd,
            onColorSelected: (Color color) {
              selectedColor = color;
            },
            OnSalva: saveQuiz,
            OnAnnulla: () => Navigator.of(context).pop(),
          );
        });
  }

  void openQuiz(int index) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => QuizPage(title: "DOMANDE")));
  }

  void modifyQuiz(int index) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AddQuizBox(
              controller: _controller,
              controllerd: _controllerd,
              onColorSelected: (Color color) {
                selectedColor = color;
              },
              OnSalva: () async {
                await LocalDataBase()
                    .updateData(Name: _controller.text, id: index + 1);
                _controller.clear();
                await LocalDataBase().getAllQuizzes();
                setState(() {
                  Navigator.of(context).pop();
                });
              },
              OnAnnulla: (() => Navigator.of(context).pop()));
        });
  }

  void deleteQuiz(int index) async {
    await LocalDataBase().deleteData(id: index + 1);
    await LocalDataBase().getAllQuizzes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(2, 67, 69, 1),
        centerTitle: true,
        title: Text('QUIZ',
            textAlign: TextAlign.left, style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        itemCount: QuizzesDataList.length,
        itemBuilder: (context, index) {
          return Tile(
            quizName: QuizzesDataList[index].name,
            quizDescription: QuizzesDataList[index].description,
            color: QuizzesDataList[index].color,
            OnOpenTile: () => openQuiz(index),
            OnOpenModifica: () => modifyQuiz(index),
            OnOpenElimina: () => deleteQuiz(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createQuiz();
        },
        child: const Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 8, 73, 108),
      ),
    );
  }
}
