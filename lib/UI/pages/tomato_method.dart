import 'package:app/UI/pages/ideal_page.dart';
import 'package:app/UI/pages/study_session.dart';
import 'package:app/UI/tiles/session_tile.dart';
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
              /*Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: GestureDetector(
                  onTap: () {
                    if (isTimerActive) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => timerPage(
                                  //vanno cambiate le variabili passate
                                  timer_attivo: deadline,
                                  pause_time:
                                      pause_time, //tutti valori da aggiungere con dataBase
                                  study_time:
                                      study_time, //tutti valori da aggiungere con dataBase
                                  nSession:
                                      4, //tutti valori da aggiungere con dataBase
                                )), // Utilizziamo il widget destinazione per la navigazione
                      );
                    } else {
                      setState(() {
                        mex = 'AVVIA UNA SESSIONE PRIMA';
                        mex_adv = 6;
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(34, 228, 15, 0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, top: 7, bottom: 10),
                          child: Text(
                            mex,
                            style: TextStyle(
                              fontFamily: 'Garamond',
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                            child: TomatoTimer(
                          deadline: deadline,
                          onDeadlineUpdated: (newDeadline) {
                            setState(() {
                              if (counter < 2 && isTimerActive) {
                                counter++;
                                metodoPomodoro(); //inizializza qui la lista dei timer e li fa partire
                              } else {
                                counter = 0;
                                isTimerActive = false;
                                mex1 = '';
                                if (mex_adv > 3) {
                                  mex_adv--;
                                } else {
                                  mex = 'ATTIVA UNA SESSIONE';
                                }
                              }
                            });
                          },
                        )),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, top: 10),
                          child: Text(
                            mex1,
                            style: TextStyle(
                              fontFamily: 'Garamond',
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              ),*/

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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StudySession(
                              studio: studyTime,
                              pausa: pauseTime,
                              volte: 4,
                              canModifyValues: false,
                              onTimerClose: (value) {
                                isTimerActive = true;
                                metodoPomodoro();
                              },
                            )), // Utilizziamo il widget destinazione per la navigazione
                  );
                },
                child: const SessionTile(
                  title: 'SESSIONE STANDARD',
                  studio: 25,
                  pausa: 7,
                  volte: 4,
                  color: Colors.redAccent,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StudySession(
                              studio: 0,
                              pausa: 0,
                              volte: 0,
                              canModifyValues: true,
                              onTimerClose: (value) {
                                isTimerActive = true;
                                metodoPomodoro();
                              },
                            )), // Utilizziamo il widget destinazione per la navigazione
                  );
                },
                child: const SessionTile(
                  title: 'PERSONALIZZATA 1',
                  studio: 0,
                  pausa: 0,
                  volte: 0,
                  color: Colors.blue,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StudySession(
                              studio: 0,
                              pausa: 0,
                              volte: 0,
                              canModifyValues: true,
                              onTimerClose: (value) {
                                isTimerActive = true;
                                metodoPomodoro();
                              },
                            )), // Utilizziamo il widget destinazione per la navigazione
                  );
                },
                child: const SessionTile(
                  title: 'PERSONALIZZATA 2',
                  studio: 0,
                  pausa: 0,
                  volte: 0,
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
                            offset: Offset(0, 3), // changes position of shadow
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
        ),
      ),
    );
  }
}
