import 'package:app/objects/timer.dart';
import 'package:app/util/sessionInterrupt.dart';
import 'package:app/util/timer_list.dart';
import 'package:flutter/material.dart';

class timerPage extends StatefulWidget {
  const timerPage(
      {super.key,
      required this.timer_attivo,
      required this.pause_time,
      required this.study_time,
      required this.nSession});
  final int nSession;
  final int pause_time;
  final int study_time;
  final DateTime timer_attivo;
  @override
  State<timerPage> createState() => _timerPageState();
}

class _timerPageState extends State<timerPage> {
  late DateTime timer; //widget.timer_attivo;

  late List<String> titleList = [];
  int counter = 0;
  late int sessions = (widget.nSession * 2) - 1;
  bool study_true = false;
  List<int> timers = [];

  List<Widget> displayedWidgets = []; //lista widget

  @override
  void initState() {
    timer = widget.timer_attivo;
    titleList.add('STUDIO RIMANENTE');
    titleList.add('PAUSA RIMANENTE');
    timers.add(widget.pause_time);
    timers.add(widget.study_time);
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
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Text(
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
                color: Color.fromARGB(104, 251, 251, 132),
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
                      style: TextStyle(
                        fontFamily: 'Garamond',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Container(
                        child: TomatoTimer(
                      deadline: timer,
                      onDeadlineUpdated: (newDeadline) {
                        reload_timer();
                        setState(() {
                          if (sessions > 0) {
                            if (sessions % 2 == 1) {
                              study_true = false;
                            } else {
                              study_true = true;
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
                    )),
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
          int p_or_s = index % 2; // Alterna tra 0 e 1
          int invers = sessions %
              2; //mi serve perchè se viene cancellato un widget, è l'ultimo e non il primo
          if (invers == 0) {
            if (p_or_s == 1) {
              p_or_s = 0;
            } else {
              p_or_s = 1;
            }
          }

          return timer_Tile(
            timer_p: widget.pause_time,
            timer_s: widget.study_time,
            p_or_s: p_or_s,
          );
        })),
      ]),
    );
  }

  void _showSessionInterruptDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return sessionInterupt();
        });
  }

  void reload_timer() {
    if (study_true) {
      timer = timer.add(Duration(minutes: widget.study_time));
    } else {
      timer = timer.add(Duration(minutes: widget.pause_time));
    }
  }
}
