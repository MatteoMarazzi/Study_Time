// ignore_for_file: prefer_const_constructors
import 'package:app/util/bottom_bar.dart';
import 'package:app/pages/exam_page.dart';
import 'package:app/pages/home_quiz_page.dart';
import 'package:app/pages/music_page.dart';
import 'package:app/pages/tomato_method.dart';
import 'package:app/util/home_tile.dart';
import 'package:app/util/QuizDB.dart';
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
  void initState() async {
    super.initState();
    await LocalDataBase().getAllQuizzes();
  }

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
                  width: 2.3,
                ),
                borderRadius: BorderRadius.circular(40),
                color: Color.fromARGB(255, 45, 118, 155),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    color: const Color.fromARGB(255, 125, 185, 215),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 8),
                    Text(
                      "RIPASSIAMO INSIEME",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          shadows: const [
                            Shadow(
                              offset: Offset(1, 2),
                              color: Color.fromARGB(255, 0, 0, 0),
                              blurRadius: 10,
                            )
                          ],
                          fontSize: 23),
                    )
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 20),
          Home_tile(
            standard: 1,
            color: Colors.black,
            shadow_color: Colors.white,
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
                  shadow_color: Colors.white,
                  backgroundColor: Colors.yellow,
                  boxTitle: "QUIZ",
                  destinationPage: HomeQuizPage(),
                  pathImage: 'assets/quiz_1.png',
                  heightImage: 130,
                  weightImage: 250,
                ),
                Home_tile(
                  standard: 2,
                  color: const Color.fromARGB(255, 0, 0, 0),
                  shadow_color: Colors.transparent,
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
            shadow_color: Colors.transparent,
            backgroundColor: Color.fromARGB(255, 176, 8, 218),
            boxTitle: "MUSICA",
            destinationPage: music_page(),
            pathImage: 'assets/music_1.png',
            heightImage: 130,
            weightImage: 250,
          )
        ],
      ))),
      bottomNavigationBar: BottomBar(),
    );
  }
}
