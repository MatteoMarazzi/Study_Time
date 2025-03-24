// ignore_for_file: prefer_const_constructors
import 'package:app/pages/home_quiz_page.dart';
import 'package:app/pages/tomato_method.dart';
import 'package:app/tiles/home_tile.dart';
import 'package:app/util/noti_service.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
          child: Center(
              child: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          //aggiunta spazio per le notifiche
          Container(
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
              children: const [
                SizedBox(height: 8),
                Text(
                  "RIPASSANDO",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 0, 0, 0),
                      shadows: [
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

          SizedBox(height: 20),
          HomeTile(
            standard: 1,
            color: Colors.black,
            shadowColor: Colors.white,
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
          HomeTile(
            standard: 1,
            color: Colors.black,
            shadowColor: Colors.white,
            backgroundColor: Color.fromARGB(98, 255, 235, 59),
            boxTitle: "QUIZ",
            destinationPage: HomeQuizPage(),
            pathImage: 'assets/quiz_1.png',
            heightImage: 130,
            weightImage: 250,
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ))),
    );
  }
}
