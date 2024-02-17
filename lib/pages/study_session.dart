import 'package:flutter/material.dart';

class studySession extends StatefulWidget {
  final int studio;
  final int pausa;
  final int volte;
  final bool canModifyValues;

  const studySession(
      {super.key,
      required this.studio,
      required this.pausa,
      required this.volte,
      required this.canModifyValues});

  @override
  State<studySession> createState() => _studySessionState();
}

class _studySessionState extends State<studySession> {
  int _counter = 20;
  int _counter_pause = 5;
  int _nSession = 1;
  Color color_p1 = Colors.black;
  Color color_p2 = Colors.black;
  Color color_p3 = Colors.black;
  Color color_m1 = Colors.black;
  Color color_m2 = Colors.black;
  Color color_m3 = Colors.black;

  void initState() {
    super.initState();
    _counter = widget.studio;
    _counter_pause = widget.pausa;
    _nSession = widget.volte;
    if (widget.canModifyValues == false) {
      color_m1 = Colors.grey;
      color_m2 = Colors.grey;
      color_m3 = Colors.grey;
      color_p3 = Colors.grey;
      color_p2 = Colors.grey;
      color_p1 = Colors.grey;
    }
  }

  void _increment_sessionCounter() {
    //NUMERO SESSIONI
    if (widget.canModifyValues == true) {
      setState(() {
        if (_nSession < 8) {
          _nSession = _nSession + 1;
          color_m3 = Colors.black;
        }
        if (_nSession == 8) {
          color_p3 = Colors.grey;
        }
      });
    }
  }

  void _decrement_sessionCounter() {
    if (widget.canModifyValues == true) {
      setState(() {
        if (_nSession > 1) {
          _nSession = _nSession - 1;
          color_p3 = Colors.black;
        }
        if (_nSession == 1) {
          color_m3 = Colors.grey;
        }
      });
    }
  }

  void _increment_pauseCounter() {
    //MIN DI PAUSA
    if (widget.canModifyValues == true) {
      setState(() {
        if (_counter_pause < 25) {
          _counter_pause = _counter_pause + 2;
          color_m2 = Colors.black;
        }
        if (_counter_pause == 25) {
          color_p2 = Colors.grey;
        }
      });
    }
  }

  void _decrement_pauseCounter() {
    if (widget.canModifyValues == true) {
      setState(() {
        if (_counter_pause > 5) {
          _counter_pause = _counter_pause - 2;
          color_p2 = Colors.black;
        }
        if (_counter_pause == 5) {
          color_m2 = Colors.grey;
        }
      });
    }
  }

  void _incrementCounter() {
    //Durata mini-sessione
    if (widget.canModifyValues == true) {
      setState(() {
        if (_counter < 60) {
          _counter = _counter + 5;
          color_m1 = Colors.black;
        }
        if (_counter == 60) {
          color_p1 = Colors.grey;
        }
      });
    }
  }

  void _decrementCounter() {
    if (widget.canModifyValues == true) {
      setState(() {
        if (_counter > 10) {
          _counter = _counter - 5;
          color_p1 = Colors.black;
        }
        if (_counter == 10) {
          color_m1 = Colors.grey;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          //va sistemato il leading
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Imposta sessione di studio',
            style: TextStyle(
                color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: screenSize.width * 0.04,
                right: screenSize.width * 0.04,
                top: screenSize.height * 0.02),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(160, 232, 224, 224),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 0.5,
                        color: Colors.black,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 4),
                    child: Text(
                      'Durata mini-sessione studio',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: screenSize.width * 1,
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 50,
                        ),
                        Text(
                          '$_counter',
                          style: TextStyle(
                              fontSize: 100.0, fontWeight: FontWeight.bold),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                _incrementCounter();
                              },
                              icon: Icon(
                                Icons.add,
                                size: 40,
                                color: color_p1,
                              ),
                              padding: EdgeInsets.all(0),
                            ),
                            IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                _decrementCounter();
                              },
                              icon: Icon(
                                Icons.remove,
                                size: 40,
                                color: color_m1,
                              ),
                              padding: EdgeInsets.all(0),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Text(
                  'minuti',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(160, 232, 224, 224),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 0.5,
                        color: Colors.black,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 4),
                    child: Text(
                      'Quanti min di pausa a round',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  width: screenSize.width * 1,
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 50,
                        ),
                        Text(
                          '$_counter_pause',
                          style: TextStyle(
                              fontSize: 100.0, fontWeight: FontWeight.bold),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                _increment_pauseCounter();
                              },
                              icon: Icon(
                                Icons.add,
                                size: 40,
                                color: color_p2,
                              ),
                              padding: EdgeInsets.all(0),
                            ),
                            IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                _decrement_pauseCounter();
                              },
                              icon: Icon(
                                Icons.remove,
                                size: 40,
                                color: color_m2,
                              ),
                              padding: EdgeInsets.all(0),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Text(
                  'minuti',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(160, 232, 224, 224),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 0.5,
                        color: Colors.black,
                      )),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                    child: Text(
                      'Quanti round nella sessione',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Sessione da :',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '$_nSession',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w400),
                    ),
                    Column(
                      children: [
                        IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            _increment_sessionCounter();
                          },
                          icon: Icon(
                            Icons.add,
                            size: 30,
                            color: color_p3,
                          ),
                          padding: EdgeInsets.all(0),
                        ),
                        IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            _decrement_sessionCounter();
                          },
                          icon: Icon(
                            Icons.remove,
                            size: 30,
                            color: color_m3,
                          ),
                          padding: EdgeInsets.all(0),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
