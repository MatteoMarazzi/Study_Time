import 'package:app/UI/util/timer.dart';
import 'package:app/domain/session.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SessionPage extends StatefulWidget {
  final Session session;

  SessionPage({required this.session, super.key});

  @override
  _SessionPageState createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  late TimerController controller;
  String turno = 'STUDIO';
  String testoPagina = 'BUONO STUDIO';
  int contatore = 0;
  Color timerTextColor = Colors.black;
  bool showCompletionContainer = false;

  @override
  void initState() {
    super.initState();
    // Elimina il controller precedente se esiste
    if (Get.isRegistered<TimerController>()) {
      Get.delete<TimerController>();
    }
    // Inizializza un nuovo controller con il callback
    controller = Get.put(TimerController(widget.session, _onTimerStart));
  }

  @override
  void dispose() {
    // Esegui azioni necessarie quando la pagina viene chiusa
    Get.delete<TimerController>();
    super.dispose();
  }

  void _onTimerStart() {
    // Esegui azioni necessarie quando il timer inizia
    print('Timer è iniziato');
    // Puoi aggiungere altre azioni qui se necessario
    setState(() {
      if (contatore < widget.session.ripetizioni * 2) {
        if (contatore % 2 == 0) {
          turno = 'STUDIO';
          timerTextColor = const Color.fromARGB(255, 183, 18, 6);
        } else {
          turno = 'PAUSA';
          timerTextColor = const Color.fromARGB(255, 4, 112, 7);
        }
        contatore++;
        print(turno);
      }
      print('contatoreee : $contatore');
      // Verifica se la sessione è completata
      if (contatore == widget.session.ripetizioni * 2) {
        showCompletionContainer = true;
        testoPagina = 'CONGRATULAZIONI\nSESSIONE TERMINATA';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/ragazzo_studioso.png'),
                fit: BoxFit
                    .contain, // Adatta l'immagine per coprire l'intero sfondo
              ),
            ),
          ),
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(
                  left: screenSize.width * 0.04,
                  right: screenSize.width * 0.04,
                  top: screenSize.height * 0.06,
                ),
                child: Column(
                  children: [
                    SizedBox(height: screenSize.height * 0.008),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(160, 232, 224, 224),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 0.5,
                          color: Colors.black,
                        ),
                      ),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 2.0, horizontal: 4),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 40),
                          child: Text(
                            'SESSIONE DI STUDIO\nIN CORSO',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.25),
                    Container(
                      height: 100,
                      width: 200,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: StadiumBorder(
                          side: BorderSide(
                            width: 2,
                            color: const Color.fromARGB(255, 255, 17, 0),
                          ),
                        ),
                      ),
                      child: Obx(
                        () => Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              turno,
                              style: TextStyle(
                                  fontSize: 16, color: timerTextColor),
                            ),
                            Text(
                              '${controller.time.value}',
                              style: TextStyle(
                                fontSize: 30,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.26),
                    Center(
                      child: Text(
                        testoPagina,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (showCompletionContainer)
            Center(
              child: Container(
                width: screenSize.width * 1,
                height: screenSize.height * 0.63,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                    image: AssetImage('assets/corridore.png'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: screenSize.width * 0.09),
        child: SizedBox(
          width: 130,
          child: Card(
            elevation: 5,
            color: Colors.white,
            shadowColor: Colors.black,
            margin: const EdgeInsets.all(0),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                animationDuration: const Duration(seconds: 5),
                overlayColor: MaterialStateProperty.all(Colors.grey),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('TERMINA',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
