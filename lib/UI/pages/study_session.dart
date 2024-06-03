import 'package:flutter/material.dart';

class StudySession extends StatefulWidget {
  final int studio;
  final int pausa;
  final int volte;
  final bool canModifyValues;
  final Function(bool) onTimerClose;
  const StudySession(
      {super.key,
      required this.studio,
      required this.pausa,
      required this.volte,
      required this.canModifyValues,
      required this.onTimerClose});

  @override
  State<StudySession> createState() => _StudySessionState();
}

class _StudySessionState extends State<StudySession> {
  int _counter = 20;
  int counterPause = 5;
  int _nSession = 1;
  Color colorP1 = Colors.black;
  Color colorP2 = Colors.black;
  Color colorP3 = Colors.black;
  Color colorM1 = Colors.black;
  Color colorM2 = Colors.black;
  Color colorM3 = Colors.black;

  @override
  void initState() {
    super.initState();
    _counter = widget.studio;
    counterPause = widget.pausa;
    _nSession = widget.volte;
    if (widget.canModifyValues == false) {
      colorM1 = Colors.grey;
      colorM2 = Colors.grey;
      colorM3 = Colors.grey;
      colorP3 = Colors.grey;
      colorP2 = Colors.grey;
      colorP1 = Colors.grey;
    } else if (widget.studio == 0 && widget.pausa == 0 && widget.volte == 0) {
      _counter = 40;
      counterPause = 15;
      _nSession = 2;
    }
  }

  void incrementSessionCounter() {
    //NUMERO SESSIONI
    if (widget.canModifyValues == true) {
      setState(() {
        if (_nSession < 8) {
          _nSession = _nSession + 1;
          colorM3 = Colors.black;
        }
        if (_nSession == 8) {
          colorP3 = Colors.grey;
        }
      });
    }
  }

  void decrementSessionCounter() {
    if (widget.canModifyValues == true) {
      setState(() {
        if (_nSession > 1) {
          _nSession = _nSession - 1;
          colorP3 = Colors.black;
        }
        if (_nSession == 1) {
          colorM3 = Colors.grey;
        }
      });
    }
  }

  void incrementPauseCounter() {
    //MIN DI PAUSA
    if (widget.canModifyValues == true) {
      setState(() {
        if (counterPause < 25) {
          counterPause = counterPause + 2;
          colorM2 = Colors.black;
        }
        if (counterPause == 25) {
          colorP2 = Colors.grey;
        }
      });
    }
  }

  void decrementPauseCounter() {
    if (widget.canModifyValues == true) {
      setState(() {
        if (counterPause > 5) {
          counterPause = counterPause - 2;
          colorP2 = Colors.black;
        }
        if (counterPause == 5) {
          colorM2 = Colors.grey;
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
          colorM1 = Colors.black;
        }
        if (_counter == 60) {
          colorP1 = Colors.grey;
        }
      });
    }
  }

  void _decrementCounter() {
    if (widget.canModifyValues == true) {
      setState(() {
        if (_counter > 10) {
          _counter = _counter - 5;
          colorP1 = Colors.black;
        }
        if (_counter == 10) {
          colorM1 = Colors.grey;
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
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        //va sistemato il leading
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Imposta sessione di studio',
          style: TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
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
                    color: const Color.fromARGB(160, 232, 224, 224),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 0.5,
                      color: Colors.black,
                    )),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 4),
                  child: Text(
                    'Durata mini-sessione studio',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: screenSize.width * 1,
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        width: 50,
                      ),
                      Text(
                        '$_counter',
                        style: const TextStyle(
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
                              color: colorP1,
                            ),
                            padding: const EdgeInsets.all(0),
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
                              color: colorM1,
                            ),
                            padding: const EdgeInsets.all(0),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const Text(
                'minuti',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(160, 232, 224, 224),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 0.5,
                      color: Colors.black,
                    )),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 4),
                  child: Text(
                    'Quanti min di pausa a round',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: screenSize.width * 1,
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        width: 50,
                      ),
                      Text(
                        '$counterPause',
                        style: const TextStyle(
                            fontSize: 100.0, fontWeight: FontWeight.bold),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              incrementPauseCounter();
                            },
                            icon: Icon(
                              Icons.add,
                              size: 40,
                              color: colorP2,
                            ),
                            padding: const EdgeInsets.all(0),
                          ),
                          IconButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              decrementPauseCounter();
                            },
                            icon: Icon(
                              Icons.remove,
                              size: 40,
                              color: colorM2,
                            ),
                            padding: const EdgeInsets.all(0),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const Text(
                'minuti',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(160, 232, 224, 224),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 0.5,
                      color: Colors.black,
                    )),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  child: Text(
                    'Quanti round nella sessione',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Sessione da :',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '$_nSession',
                    style: const TextStyle(
                        fontSize: 40, fontWeight: FontWeight.w400),
                  ),
                  Column(
                    children: [
                      IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          incrementSessionCounter();
                        },
                        icon: Icon(
                          Icons.add,
                          size: 30,
                          color: colorP3,
                        ),
                        padding: const EdgeInsets.all(0),
                      ),
                      IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          decrementSessionCounter();
                        },
                        icon: Icon(
                          Icons.remove,
                          size: 30,
                          color: colorM3,
                        ),
                        padding: const EdgeInsets.all(0),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: screenSize.width * 0.09),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              width: 130,
              child: Card(
                elevation: 5,
                color: Colors.white,
                shadowColor: Colors.black,
                margin: const EdgeInsets.all(0),
                child: TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    animationDuration: const Duration(seconds: 5),
                    overlayColor: MaterialStateProperty.all(Colors.grey),
                    // Altre personalizzazioni come colori, bordi, ecc.
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Salva',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 130,
              child: Card(
                elevation: 5,
                color: Colors.white,
                shadowColor: Colors.black,
                margin: const EdgeInsets.all(0),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      widget.onTimerClose(true);
                    });
                  },
                  style: ButtonStyle(
                    animationDuration: const Duration(seconds: 5),
                    overlayColor: MaterialStateProperty.all(Colors.grey),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Avvia',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
