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

  @override
  void initState() {
    super.initState();
    controller = Get.put(TimerController(widget.session));
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
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
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  // aggiunta spazio per le notifiche
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
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 40),
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
                      () => Center(
                        child: Text(
                          '${controller.time.value}',
                          style: TextStyle(
                            fontSize: 30,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.28),
                  Center(
                    child: Text(
                      "BUONO STUDIO",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
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
