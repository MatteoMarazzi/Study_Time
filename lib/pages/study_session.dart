import 'package:flutter/material.dart';

class studySession extends StatefulWidget {
  const studySession({super.key});

  @override
  State<studySession> createState() => _studySessionState();
}

class _studySessionState extends State<studySession> {
  int _counter = 20;
  int _counter_pause = 5;
  int _nSession = 1;

  void _increment_sessionCounter() {
    setState(() {
      if (_nSession < 8) {
        _nSession = _nSession + 1;
      }
    });
  }

  void _decrement_sessionCounter() {
    setState(() {
      if (_nSession >= 1) {
        _nSession = _nSession - 1;
      }
    });
  }

  void _increment_pauseCounter() {
    setState(() {
      if (_counter_pause < 25) {
        _counter_pause = _counter_pause + 2;
      }
    });
  }

  void _decrement_pauseCounter() {
    setState(() {
      if (_counter_pause > 5) {
        _counter_pause = _counter_pause - 2;
      }
    });
  }

  void _incrementCounter() {
    setState(() {
      if (_counter < 60) {
        _counter = _counter + 5;
      }
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 10) {
        _counter = _counter - 5;
      }
    });
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
                Text(
                  'Durata mini-sessione',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
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
                Text(
                  'Ogni $_counter, quanti min di pausa',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
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
                Text(
                  'Quante mini-sessioni vuoi fare',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
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
