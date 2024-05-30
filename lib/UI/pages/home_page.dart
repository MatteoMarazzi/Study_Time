// ignore_for_file: prefer_const_constructors
import 'package:app/databases/quizDB.dart';
import 'package:app/UI/pages/exam_page.dart';
import 'package:app/UI/pages/home_quiz_page.dart';
import 'package:app/UI/pages/tomato_method.dart';
import 'package:app/UI/tiles/home_tile.dart';
import 'package:app/domain/utente.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Utente().mountDatabase();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
                  width: 2.3,
                ),
                borderRadius: BorderRadius.circular(40),
                color: Color.fromARGB(255, 239, 231, 231),
              ),
              child: Column(
                children: [
                  SizedBox(height: 8),
                  Text(
                    "RIPASSANDO",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0),
                        shadows: const [
                          /*Shadow(
                            offset: Offset(1, 2),
                            color: Color.fromARGB(255, 0, 0, 0),
                            blurRadius: 10,
                          )*/
                        ],
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
            shadow_color: Colors.white,
            backgroundColor: const Color.fromARGB(99, 244, 67, 54),
            boxTitle: "POMODORO",
            destinationPage: TomatoMethod(),
            pathImage: 'assets/tomato_2.png',
            heightImage: 130,
            weightImage: 250,
          ),
          SizedBox(height: 20),
          //SingleChildScrollView(
          // scrollDirection: Axis.horizontal,
          //child: Row(
          // children: [
          Home_tile(
            standard: 1,
            color: Colors.black,
            shadow_color: Colors.white,
            backgroundColor: Color.fromARGB(98, 255, 235, 59),
            boxTitle: "QUIZ",
            destinationPage: HomeQuizPage(utente: Utente()),
            pathImage: 'assets/quiz_1.png',
            heightImage: 130,
            weightImage: 250,
          ),
          SizedBox(
            height: 20,
          ),
          Home_tile(
            standard: 1,
            color: const Color.fromARGB(255, 0, 0, 0),
            shadow_color: Color.fromARGB(255, 255, 255, 255),
            backgroundColor: Color.fromARGB(99, 39, 199, 74),
            boxTitle: "ESAMI",
            destinationPage: Exam_page(),
            pathImage: 'assets/exam_1.png',
            heightImage: 130,
            weightImage: 250,
          ),
          // ],
          // ),
          // ),
        ],
      ))),
    );
  }
}
