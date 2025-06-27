// ignore_for_file: prefer_const_constructors
import 'dart:math';

import 'package:app/pages/home_quiz_page.dart';
import 'package:app/pages/quiz_editor_page.dart';
import 'package:app/pages/quiz_execution_page.dart';
import 'package:app/pages/sessionPage.dart';
import 'package:app/pages/tomato_method.dart';
import 'package:app/tiles/home_tile.dart';
import 'package:app/util/common_functions.dart';
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
  TimeOfDay? _selectedTime;
  int _currentStreak = 0;
  final List<bool> _last7Days = List.generate(7, (_) => Random().nextBool());
  bool _hasQuizzes = false;
  Color selectedColor = Colors.white;
  final quizNameController = TextEditingController();
  final quizDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    requestNotificationPermission();
    _loadStreak();
    _checkQuizzesAvailability();
  }

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

  Future<void> _loadStreak() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final docSnap =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (!docSnap.exists) {
      setState(() {
        _last7Days.fillRange(0, 7, false);
        _currentStreak = 0;
      });
      return;
    }

    final data = docSnap.data()!;
    final rawHistory = data['loginHistory'];
    final history = rawHistory is Map
        ? Map<String, bool>.from(rawHistory)
        : <String, bool>{};

    final today = DateTime.now();
    final todayMid = DateTime(today.year, today.month, today.day);

    final startOfWeek = todayMid.subtract(Duration(days: todayMid.weekday - 1));

    final last7 = List<bool>.generate(7, (i) {
      final d = startOfWeek.add(Duration(days: i));
      final key =
          "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
      return history[key] == true;
    });

    setState(() {
      _last7Days.setAll(0, last7);
      _currentStreak =
          (data['currentStreak'] as int?) ?? last7.where((b) => b).length;
    });
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

  Future<void> _checkQuizzesAvailability() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final snap = await FirebaseFirestore.instance
        .collection('quizzes')
        .where('creator', isEqualTo: uid)
        .limit(10)
        .get();

    for (var quiz in snap.docs) {
      final fcSnap =
          await quiz.reference.collection('flashcards').limit(1).get();
      if (fcSnap.docs.isNotEmpty) {
        setState(() => _hasQuizzes = true);
        return;
      }
    }
    setState(() => _hasQuizzes = false);
  }

  Future<void> uploadQuizToDb() async {
    try {
      await FirebaseFirestore.instance.collection("quizzes").add({
        "creator": FirebaseAuth.instance.currentUser!.uid,
        "name": quizNameController.text.trim(),
        "description": quizDescriptionController.text.trim(),
        "color": rgbToHex(selectedColor),
        "reviewEnabled": true
      });
      quizNameController.clear();
      quizDescriptionController.clear();
      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final todayMid = DateTime(today.year, today.month, today.day);
    final startOfWeek = todayMid.subtract(Duration(days: todayMid.weekday - 1));
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
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'HOME',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    //decoration: TextDecoration.underline,
                    decorationThickness: 1),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Streak accesso: $_currentStreak ${_currentStreak == 1 ? 'giorno' : 'giorni'}',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 25),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 60,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(0, 255, 255, 255),
                            spreadRadius: 1,
                            blurRadius: 1,
                            blurStyle: BlurStyle.normal),
                      ],
                      color: const Color.fromARGB(100, 230, 233, 235),
                      border: Border.all(width: 1, color: Colors.black),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _last7Days.length,
                        itemBuilder: (context, index) {
                          final day = startOfWeek.add(Duration(days: index));
                          final weekdayLabel = [
                            'Lun',
                            'Mar',
                            'Mer',
                            'Gio',
                            'Ven',
                            'Sab',
                            'Dom',
                          ][day.weekday - 1];
                          final did = _last7Days[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                Text(weekdayLabel),
                                SizedBox(height: 4),
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.03, color: Colors.black),
                                    shape: BoxShape.circle,
                                    color: did
                                        ? Colors.green
                                        : const Color.fromARGB(
                                            255, 255, 255, 255),
                                  ),
                                  child: did
                                      ? Icon(Icons.check,
                                          size: 18,
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255))
                                      : SizedBox.shrink(),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text('Azioni rapide',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.5,
                  children: [
                    _buildActionCard(
                      icon: Icons.flash_on,
                      label: 'Ripeti ultima sessione',
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SessionPage(
                                ripetizioni: latestSession['ripetizioni'],
                                minutiStudio: latestSession['minutiStudio'],
                                minutiPausa: latestSession['minutiPausa']),
                          ),
                        );
                      },
                    ),
                    _buildActionCard(
                      icon: Icons.library_books_outlined,
                      label: 'Ripassa flashcards',
                      onTap: _hasQuizzes
                          ? () {
                              () async {
                                var randomQuiz = await getRandomQuiz();
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        QuizExecutionPage(quiz: randomQuiz),
                                  ),
                                );
                              }();
                            }
                          : null,
                    ),
                    _buildActionCard(
                        icon: Icons.notifications_active_rounded,
                        label: 'Imposta orario notifica',
                        onTap: _pickTime),
                    _buildActionCard(
                        icon: Icons.lightbulb,
                        label: 'Aggiungi un nuovo quiz',
                        onTap: () {
                          () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => QuizEditorPage(
                                        controller: quizNameController,
                                        controllerd: quizDescriptionController,
                                        onColorSelected: (Color color) {
                                          selectedColor = color;
                                        },
                                        onSalva: uploadQuizToDb,
                                        onAnnulla: () =>
                                            Navigator.of(context).pop(),
                                      )),
                            );
                          }();
                        }),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text('Sessioni studio',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(
                height: 20,
              ),
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

              /* Container(
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
                            onTap: _hasQuizzes
                                ? () async {
                                    var randomQuiz = await getRandomQuiz();
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              QuizExecutionPage(
                                                quiz: randomQuiz,
                                              )),
                                    );
                                  }
                                : null,
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
                                      color: _hasQuizzes
                                          ? Colors.black
                                          : Colors.grey,
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
                  )),*/
            ],
          ));
        },
      ),
    );
  }
}

Widget _buildActionCard({
  required IconData icon,
  required String label,
  VoidCallback? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: Colors.blueAccent),
          SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
  );
}

Widget _sessionAction(String text) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
