// ignore_for_file: prefer_const_constructors

import 'package:app/pages/exam_page.dart';
import 'package:app/pages/home_quiz_page.dart';
import 'package:app/pages/music_page.dart';
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
            title: Text(
              widget.title,
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            actions: [
              IconButton(
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
            ]),
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
              weightImage: 250,
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
            ),
            SizedBox(height: 20),
            Home_tile(
              color: const Color.fromARGB(255, 0, 0, 0),
              backgroundColor: Color.fromARGB(255, 176, 8, 218),
              boxTitle: "MUSICA",
              destinationPage: music_page(),
              pathImage: 'assets/music_1.png',
              heightImage: 130,
              weightImage: 250,
            )
          ],
        ))));
  }
}
