import 'package:app/UI/pages/timer.dart';
import 'package:app/UI/util/sessionInterrupt.dart';
import 'package:app/UI/util/timer_list.dart';
import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  const TimerPage(
      {super.key,
      required this.timerAttivo,
      required this.pauseTime,
      required this.studyTime,
      required this.nSession});
  final int nSession;
  final int pauseTime;
  final int studyTime;
  final DateTime timerAttivo;
  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  late DateTime timer; //widget.timer_attivo;

  late List<String> titleList = [];
  int counter = 0;
  late int sessions = (widget.nSession * 2) - 1;
  bool studyTrue = false;
  List<int> timers = [];

  List<Widget> displayedWidgets = []; //lista widget

  @override
  void initState() {
    timer = widget.timerAttivo;
    titleList.add('STUDIO RIMANENTE');
    titleList.add('PAUSA RIMANENTE');
    timers.add(widget.pauseTime);
    timers.add(widget.studyTime);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              _showSessionInterruptDialog();
            } // Utilizziamo il widget destinazione per la navigazione
            ,
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: const Text(
          'SESSIONE DI STUDIO',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: CustomScrollView(physics: const ClampingScrollPhysics(), slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(
                left: screenSize.width * 0.04,
                right: screenSize.width * 0.04,
                top: 10,
                bottom: 20),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(104, 251, 251, 132),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      left: 8,
                      right: 8,
                    ),
                    child: Text(
                      titleList[counter],
                      style: const TextStyle(
                        fontFamily: 'Garamond',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: TomatoTimer(
                      deadline: timer,
                      onDeadlineUpdated: (newDeadline) {
                        reloadTimer();
                        setState(() {
                          if (sessions > 0) {
                            if (sessions % 2 == 1) {
                              studyTrue = false;
                            } else {
                              studyTrue = true;
                            }
                            if (counter == 1) {
                              counter = 0;
                            } else {
                              counter++;
                            }
                            sessions--;
                            if (displayedWidgets.isNotEmpty) {
                              displayedWidgets.removeLast();
                            }
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(childCount: sessions,
                (context, index) {
          //variabile 8 da cambiare, in base alle volte
          int pOrS = index % 2; // Alterna tra 0 e 1
          int invers = sessions %
              2; //mi serve perchè se viene cancellato un widget, è l'ultimo e non il primo
          if (invers == 0) {
            if (pOrS == 1) {
              pOrS = 0;
            } else {
              pOrS = 1;
            }
          }

          return TimerTile(
            timerP: widget.pauseTime,
            timerS: widget.studyTime,
            pOrS: pOrS,
          );
        })),
      ]),
    );
  }

  void _showSessionInterruptDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const SessionInterupt();
        });
  }

  void reloadTimer() {
    if (studyTrue) {
      timer = timer.add(Duration(minutes: widget.studyTime));
    } else {
      timer = timer.add(Duration(minutes: widget.pauseTime));
    }
  }
}
