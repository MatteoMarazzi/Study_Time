import 'dart:io';

import 'package:app/pages/quiz_page.dart';
import 'package:app/util/Quiz.dart';
import 'package:app/util/add_quiz_box.dart';
import 'package:app/util/tile.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
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
  List<Quiz> quizzes = [];

  final _controller = TextEditingController();
  final _controllerd = TextEditingController();

  Color selectedColor = Colors.black;

  void saveQuiz(Color selectedColor) async {
    if (_controller.text != Null) {
      setState(() {
        quizzes.add(Quiz(
          nome: _controller.text,
          id: quizzes.length,
          descrizione: _controllerd.text,
          quizColor: selectedColor,
        ));
        //storage(quizzes.last);
        _controller.clear();
        _controllerd.clear();
      });
    }
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
              selectedColor = color; // Imposta il colore selezionato
            },
            OnSalva: () {
              saveQuiz(selectedColor);
            },
            OnAnnulla: () => Navigator.of(context).pop(),
          );
        });
  }

  void openQuiz(int index) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => QuizPage(title: "DOMANDE")));
  }

  modifyQuiz(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AddQuizBox(
              controller: _controller,
              controllerd: _controllerd,
              onColorSelected: (Color color) {
                selectedColor = color; // Imposta il colore selezionato
              },
              OnSalva: () {
                setState(() {
                  quizzes[index].nome = _controller.text;
                  quizzes[index].descrizione = _controllerd.text;
                  quizzes[index].quizColor = selectedColor;
                  Navigator.of(context).pop();
                });
              },
              OnAnnulla: (() => Navigator.of(context).pop()));
        });
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
        padding: EdgeInsets.only(
          left: 17,
          right: 17,
          bottom: 20,
          top: 15,
        ), //contorno intera lista

        itemCount: quizzes.length,
        itemBuilder: (context, index) {
          return Tile(
            quizName: quizzes[index].nome,
            quizDescription: quizzes[index].descrizione,
            color: quizzes[index].quizColor,
            OnOpenTile: () => openQuiz(index),
            OnOpenElimina: () => setState(() {
              quizzes.removeAt(index);
            }),
            OnOpenModifica: () => modifyQuiz(index),
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
