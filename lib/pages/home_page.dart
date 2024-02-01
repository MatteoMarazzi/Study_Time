// ignore_for_file: prefer_const_constructors
import 'package:app/pages/calendar_page.dart';
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
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: const Color.fromRGBO(175, 238, 238, 1.0),
/*        appBar: AppBar(
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
            ]),*/

        body: SingleChildScrollView(
            child: Center(
                child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            //aggiunta spazio per le notifiche
            Padding(
              padding: EdgeInsets.only(
                  left: screenSize.width * 0.04,
                  right: screenSize.width * 0.04,
                  top: screenSize.height * 0.06),
              child: Container(
                height: 300,
                width: 350,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.blueGrey,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 8),
                    Text(
                      "DOMANDE CASUALI",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 23),
                    )
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),
            Home_tile(
              standard: 1,
              color: Colors.black,
              backgroundColor: Colors.red,
              boxTitle: "POMODORO",
              destinationPage: TomatoMethod(),
              pathImage: 'assets/tomato_2.png',
              heightImage: 130,
              weightImage: 250,
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Home_tile(
                    standard: 2,
                    color: Colors.black,
                    backgroundColor: Colors.yellow,
                    boxTitle: "QUIZ",
                    destinationPage: HomeQuizPage(title: "QUIZ"),
                    pathImage: 'assets/quiz_1.png',
                    heightImage: 130,
                    weightImage: 250,
                  ),
                  Home_tile(
                    standard: 2,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    backgroundColor: Color.fromARGB(255, 39, 199, 74),
                    boxTitle: "ESAMI",
                    destinationPage: Exam_page(),
                    pathImage: 'assets/exam_1.png',
                    heightImage: 130,
                    weightImage: 250,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Home_tile(
              standard: 1,
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
