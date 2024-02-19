import 'package:app/objects/timer.dart';
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
  late DateTime timer = widget.timer_attivo;
  late List<String> titleList = [];
  int counter = 0;
  late int sessions = (widget.nSession * 2) - 1;
  bool study_true = false;
  List<int> timers = [];

  @override
  void initState() {
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
              Navigator.of(context).pop();
            },
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
                color: Color.fromARGB(104, 132, 213, 251),
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
            delegate: SliverChildBuilderDelegate(
                childCount: (widget.nSession * 2 - 1), (context, index) {
          //variabile 8 da cambiare, in base alle volte
          final timerIndex = index % 2; // Alterna tra 0 e 1
          final p_or_s = index % 2; // Alterna tra 0 e 1
          return timer_Tile(timer: timers[timerIndex], p_or_s: p_or_s);
        })),
      ]),
    );
  }

  void reload_timer() {
    if (study_true) {
      timer = timer.add(Duration(minutes: widget.study_time));
    } else {
      timer = timer.add(Duration(minutes: widget.pause_time));
    }
  }
}
/*
    ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 8,
                itemBuilder: (context, index) {
                  final timerIndex = index % 2; // Alterna tra 0 e 1
                  final p_or_s = index % 2; // Alterna tra 0 e 1
                  return timer_Tile(
                      timer: timers[timerIndex], p_or_s: p_or_s);
                },
              ),


class ContainerList extends StatefulWidget {
  @override
  _ContainerListState createState() => _ContainerListState();
}

class _ContainerListState extends State<ContainerList> {
  List<Widget> containers = []; // Lista di widget Container

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              // Aggiungi un nuovo container alla lista quando il pulsante viene premuto
              containers.add(
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.blue,
                  margin: EdgeInsets.all(10),
                ),
              );
            });
          },
          child: Text('Aggiungi Container'),
        ),
        Expanded(
          child: ListView(
            children: containers, // Mostra tutti i container nella lista
          ),
        ),
      ],
    );
  }
}*/
