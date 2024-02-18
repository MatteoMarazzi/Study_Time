import 'package:app/objects/bottom_bar.dart';
import 'package:app/objects/timer.dart';
import 'package:app/pages/study_session.dart';
import 'package:app/pages/timer_page.dart';
import 'package:app/util/session_tile.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class TomatoMethod extends StatefulWidget {
  const TomatoMethod({super.key});

  @override
  State<TomatoMethod> createState() => _TomatoMethodState();
}

class _TomatoMethodState extends State<TomatoMethod> {
  late Timer selectedTimer;
  late DateTime timer_attivo = DateTime.now().add(const Duration(seconds: 0));
  DateTime deadline = DateTime.now().add(const Duration(seconds: 0));
  int counter = 0; //dovrà diventare il numero di volte * 2 (sessione)

  late List<DateTime> dateTimes = [];

  @override
  void metodo_pomodoro() {
    dateTimes.add(DateTime.now().add(const Duration(minutes: 25)));
    dateTimes.add(DateTime.now().add(const Duration(minutes: 32)));
    dateTimes.add(DateTime.now().add(const Duration(minutes: 57)));
    dateTimes.add(DateTime.now().add(const Duration(minutes: 64)));
    dateTimes.add(DateTime.now().add(const Duration(minutes: 89)));
    dateTimes.add(DateTime.now().add(const Duration(minutes: 96)));
    dateTimes.add(DateTime.now().add(const Duration(minutes: 121)));
    dateTimes.add(DateTime.now().add(const Duration(minutes: 128)));
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => timerPage(
                                //vanno cambiate le variabili passate
                                timer_attivo: timer_attivo,
                                pause_time: 7,
                                study_time: 25,
                              )), // Utilizziamo il widget destinazione per la navigazione
                    );
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
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'AVVIA LA TUA SESSIONE',
                            style: TextStyle(
                              fontFamily: 'Garamond',
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(bottom: 20),
                            child: TomatoTimer(
                              deadline: deadline,
                              onDeadlineUpdated: (newDeadline) {
                                setState(() {
                                  if (counter < 8) {
                                    metodo_pomodoro(); //inizializza qui la lista dei timer e li fa partire
                                    deadline = dateTimes[counter];
                                    timer_attivo = dateTimes[counter];
                                    counter++;
                                  } else {
                                    counter = 0;
                                  }
                                });
                              },
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              Text(
                'SESSIONI DI STUDIO',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationThickness: 1),
              ),
              sessionTile(
                title: 'SESSIONE STANDARD',
                studio: 25,
                pausa: 7,
                volte: 4,
                color: Colors.redAccent,
                canModifyValues: false,
              ),
              sessionTile(
                title: 'PERSONALIZZATA 1',
                studio: 0,
                pausa: 0,
                volte: 0,
                color: Colors.blue,
                canModifyValues: true,
              ),
              sessionTile(
                title: 'PERSONALIZZATA 2',
                studio: 0,
                pausa: 0,
                volte: 0,
                color: Colors.green,
                canModifyValues: true,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
