// ignore_for_file: prefer_const_constructors
import 'dart:math';

import 'package:app/pages/home_quiz_page.dart';
import 'package:app/pages/quiz_execution_page.dart';
import 'package:app/pages/sessionPage.dart';
import 'package:app/pages/tomato_method.dart';
import 'package:app/tiles/home_tile.dart';
import 'package:app/util/noti_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

Future<void> requestNotificationPermission() async {
  var status = await Permission.notification.status;
  if (!status.isGranted) {
    await Permission.notification.request();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    requestNotificationPermission();
  }

  TimeOfDay? _selectedTime;

  Future<void> _pickTime() async {
    final now = TimeOfDay.now();
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? now,
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
      NotiService().sendDailyNotificationForRandomQuiz(
          _selectedTime!.hour, _selectedTime!.minute);
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getRandomQuiz() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('quizzes')
        .where('creator', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    List<DocumentSnapshot<Map<String, dynamic>>> quizzesWithFlashcards = [];

    for (var quiz in snapshot.docs) {
      var flashcardsSnapshot =
          await quiz.reference.collection('flashcards').limit(1).get();

      if (flashcardsSnapshot.docs.isNotEmpty) {
        quizzesWithFlashcards.add(quiz);
      }
    }

    var random = Random();
    var randomQuiz =
        quizzesWithFlashcards[random.nextInt(quizzesWithFlashcards.length)];

    return randomQuiz;
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('sessions')
            .orderBy('ultimoAvvio', descending: true)
            .limit(1)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var latestSession = snapshot.data!.docs.first;

          return Center(
              child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              //aggiunta spazio per le notifiche
              const SizedBox(
                height: 20,
              ),
              const Text(
                'STUDY TIME',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    //decoration: TextDecoration.underline,
                    decorationThickness: 1),
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

              Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 4, color: Colors.yellow),
                    color: const Color.fromARGB(236, 238, 232, 185),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "AZIONI RAPIDE",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          //decoration: TextDecoration.underline,
                          decorationThickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SessionPage(
                                      ripetizioni: latestSession['ripetizioni'],
                                      minutiStudio:
                                          latestSession['minutiStudio'],
                                      minutiPausa:
                                          latestSession['minutiPausa']),
                                ),
                              );
                            },
                            child: Container(
                              height: 100,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "RIPETI ULTIMA SESSIONE",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      //decoration: TextDecoration.underline,
                                      decorationThickness: 1,
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                            onTap: () async {
                              var randomQuiz = await getRandomQuiz();
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => QuizExecutionPage(
                                          quiz: randomQuiz,
                                        )),
                              );
                            },
                            child: Container(
                              width: 500,
                              height: 100,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "RIPASSA FLASHCARDS",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      //decoration: TextDecoration.underline,
                                      decorationThickness: 1,
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: _pickTime,
                          child: Container(
                            height: 100,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'NOTIFICHE GIORNALIERE',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    _selectedTime != null
                                        ? 'Il prossimo ripasso sarà alle: ${_selectedTime!.format(context)}'
                                        : 'Tocca per impostare l\'orario',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ));
        },
      ),
    );
  }
}
