import 'package:app/pages/exam_page.dart';
import 'package:app/pages/home_quiz_page.dart';
import 'package:app/pages/tomato_method.dart';
import 'package:app/util/home_tile.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(175, 238, 238, 1.0),
        appBar: AppBar(
            backgroundColor: const Color.fromRGBO(2, 67, 69, 1),
            title: Stack(
              //nuova funzione che permette di sovrapposizionare dei Widget, utilissimo per libertà di posizionamento
              children: [
                Center(
                  child: Text(
                    widget.title,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Positioned(
                  //scelta di usare il positioned per infinita possibilita di posizionamento.
                  right: 0,
                  bottom: -9,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeQuizPage(title: "QUIZ"),
                        ),
                      );
                    },
                    icon: Image.asset('assets/tomato.png'),
                  ),
                ),
              ],
            )),
        body: SingleChildScrollView(
            child: Center(
                child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(height: 20),
            Home_tile(
              color: Colors.black,
              backgroundColor: Colors.red,
              boxTitle: "POMODORO",
              destinationPage: TomatoMethod(),
              pathImage: 'assets/tomato_2.png',
              heightImage: 130,
              weightImage: 250,
            ),
            SizedBox(height: 20),
            Home_tile(
              color: Colors.black,
              backgroundColor: Colors.yellow,
              boxTitle: "QUIZ",
              destinationPage: HomeQuizPage(title: "QUIZ"),
              pathImage: 'assets/quiz_1.png',
              heightImage: 130,
              weightImage: 240,
            ),
            SizedBox(height: 20),
            Home_tile(
              color: const Color.fromARGB(255, 0, 0, 0),
              backgroundColor: Color.fromARGB(255, 39, 199, 74),
              boxTitle: "ESAMI",
              destinationPage: Exam_page(),
              pathImage: 'assets/exam_1.png',
              heightImage: 130,
              weightImage: 250,
            )
          ],
        ))));
  }
}
