import 'package:app/UI/pages/ideal_page.dart';
import 'package:app/UI/pages/study_session.dart';
import 'package:app/UI/tiles/session_tile.dart';
import 'package:app/domain/utente.dart';
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

  void navigateToStudySession(int sessionId, bool canModifyValues) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudySession(
          session: Utente().getSession(sessionId),
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
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            left: screenSize.width * 0.02,
            right: screenSize.width * 0.02,
            top: screenSize.height * 0.06),
        child: SingleChildScrollView(
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
                  navigateToStudySession(1, false);
                },
                child: SessionTile(
                  title: 'STANDARD',
                  session: Utente().getSession(1),
                  color: Colors.redAccent,
                ),
              ),
              GestureDetector(
                onTap: () {
                  navigateToStudySession(2, true);
                },
                child: SessionTile(
                  title: 'PERSONALIZZATA 1',
                  session: Utente().getSession(2),
                  color: Colors.blue,
                ),
              ),
              GestureDetector(
                onTap: () {
                  navigateToStudySession(3, true);
                },
                child: SessionTile(
                  title: 'PERSONALIZZATA 2',
                  session: Utente().getSession(3),
                  color: Colors.green,
                ),
              ),
              const SizedBox(
                height: 10,
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
                  child: const Text(
                    'Perchè crearsi una sessione di studio personalizzata ?',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        //decoration: TextDecoration.underline,
                        decorationThickness: 1),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
