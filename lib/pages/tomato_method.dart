import 'package:app/pages/ideal_page.dart';
import 'package:app/pages/study_session.dart';
import 'package:app/tiles/session_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TomatoMethod extends StatefulWidget {
  const TomatoMethod({super.key});

  @override
  State<TomatoMethod> createState() => _TomatoMethodState();
}

class _TomatoMethodState extends State<TomatoMethod> {
  DateTime deadline = DateTime.now();
  int counter = 0; //dovrà diventare il numero di volte * 2 (sessione)
  int mexAdv = 0;
  final int studyTime = 10;
  final int pauseTime = 5;
  late bool isTimerActive = false;
  String mex = 'ATTIVA UNA SESSIONE';
  String mex1 = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      counter = 0;
      isTimerActive = false;
      mex = 'ATTIVA UNA SESSIONE';
      mex1 = '';
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Any logic to handle when dependencies change can go here
    setState(() {});
  }

  void metodoPomodoro() {
    if (isTimerActive) {
      deadline = DateTime.now();
      if (counter % 2 == 1) {
        mex = 'SESSIONE ATTIVA ';
        mex1 = '(STUDIO)';
        deadline = deadline.add(Duration(minutes: studyTime));
      } else {
        mex = 'SESSIONE ATTIVA';
        mex1 = '(PAUSA)';
        deadline = deadline.add(Duration(minutes: pauseTime));
      }
    }
  }

  void navigateToStudySession(String sessionName, int minutiStudio,
      int minutiPausa, int ripetizioni, bool canModifyValues) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudySession(
          session: FirebaseFirestore.instance
              .collection('sessions')
              .doc(sessionName),
          minutiPausa: minutiPausa,
          minutiStudio: minutiStudio,
          ripetizioni: ripetizioni,
          canModifyValues: canModifyValues,
          onTimerClose: (value) {
            setState(() {
              isTimerActive = true;
              metodoPomodoro();
            });
          },
        ),
      ),
    );
    // This will trigger a rebuild when returning from StudySession
    setState(() {});
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
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final sessions = snapshot.data!.docs;
            Map<String, Map<String, dynamic>> sessionsMap = {};
            for (var doc in sessions) {
              sessionsMap[doc.id] = doc.data();
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'SESSIONI DI STUDIO',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        //decoration: TextDecoration.underline,
                        decorationThickness: 1),
                  ),
                  GestureDetector(
                    onTap: () {
                      navigateToStudySession(
                          'standard',
                          sessionsMap['standard']?['minutiStudio'] ?? 0,
                          sessionsMap['standard']?['minutiPausa'] ?? 0,
                          sessionsMap['standard']?['ripetizioni'] ?? 0,
                          false);
                    },
                    child: SessionTile(
                      title: 'STANDARD',
                      minutiStudio:
                          sessionsMap['standard']?['minutiStudio'] ?? 0,
                      minutiPausa: sessionsMap['standard']?['minutiPausa'] ?? 0,
                      ripetizioni: sessionsMap['standard']?['ripetizioni'] ?? 0,
                      color: Colors.redAccent,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      navigateToStudySession(
                          'personalizzata1',
                          sessionsMap['personalizzata1']?['minutiStudio'] ?? 0,
                          sessionsMap['personalizzata1']?['minutiPausa'] ?? 0,
                          sessionsMap['personalizzata1']?['ripetizioni'] ?? 0,
                          true);
                    },
                    child: SessionTile(
                      title: 'PERSONALIZZATA 1',
                      minutiStudio:
                          sessionsMap['personalizzata1']?['minutiStudio'] ?? 0,
                      minutiPausa:
                          sessionsMap['personalizzata1']?['minutiPausa'] ?? 0,
                      ripetizioni:
                          sessionsMap['personalizzata1']?['ripetizioni'] ?? 0,
                      color: Colors.blue,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      navigateToStudySession(
                          'personalizzata2',
                          sessionsMap['personalizzata2']?['minutiStudio'] ?? 0,
                          sessionsMap['personalizzata2']?['minutiPausa'] ?? 0,
                          sessionsMap['personalizzata2']?['ripetizioni'] ?? 0,
                          true);
                    },
                    child: SessionTile(
                      title: 'PERSONALIZZATA 2',
                      minutiStudio:
                          sessionsMap['personalizzata2']?['minutiStudio'] ?? 0,
                      minutiPausa:
                          sessionsMap['personalizzata2']?['minutiPausa'] ?? 0,
                      ripetizioni:
                          sessionsMap['personalizzata2']?['ripetizioni'] ?? 0,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  IdealPage(), // Utilizziamo il widget destinazione per la navigazione
                            ),
                          );
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Perchè crearsi una sessione di studio personalizzata ?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                //decoration: TextDecoration.underline,
                                decorationThickness: 1,
                              ),
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
