import 'dart:io';

import 'package:app/pages/quiz_page.dart';
import 'package:app/objects/quiz.dart';
import 'package:app/util/add_quiz_box.dart';
import 'package:app/util/localDB.dart';
import 'package:app/util/tile.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class HomeQuizPage extends StatefulWidget {
  const HomeQuizPage({super.key, required this.title});
  final String title;

  @override
  State<HomeQuizPage> createState() => _HomeQuizPageState();
}

class _HomeQuizPageState extends State<HomeQuizPage> {
  //List<Quiz> quizzes = [];

  final _controller = TextEditingController();

  void saveQuiz() async {
    await LocalDataBase().addDataLocally(Name: _controller.text);
    await LocalDataBase().readAllData();
    _controller.clear();
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
              OnSalva: () async {
                await LocalDataBase()
                    .updateData(Name: _controller.text, id: index + 1);
                _controller.clear();
                await LocalDataBase().readAllData();
                setState(() {
                  Navigator.of(context).pop();
                });
              },
              OnAnnulla: (() => Navigator.of(context).pop()));
        });
  }

  void deleteQuiz(int index) async {
    await LocalDataBase().deleteData(id: index + 1);
    await LocalDataBase().readAllData();
    setState(() {});
  }

/*  Future storage(Quiz q) async {
    Directory d = await getApplicationDocumentsDirectory();
    File f = File("${d.path}/prova.txt");
    f.writeAsString("hello");

    var dbpath = await getDatabasesPath();
    var fname = dbpath + "/prova.txt";

    var db = await openDatabase(fname, onCreate: (db, version) {
      print("db not found, creating a new one");
      db.execute('''
          CREATE TABLE quizzes(
            nome varchar
            id int,
          )''');
    }, version: 1);
    db.insert("quizzes", q.toMap());
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(2, 67, 69, 1),
        centerTitle: true,
        title: Text(
            textAlign: TextAlign.left,
            widget.title,
            style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        itemCount: WholeDataList.length,
        itemBuilder: (context, index) {
          return Tile(
            quizName: WholeDataList[index]['Name'],
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
