import 'package:app/objects/bottom_bar.dart';
import 'package:app/objects/timer.dart';
import 'package:app/pages/study_session.dart';
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
  String _null = 'AVVIA LA TUA SESSIONE';
  String _active = 'SESSIONE IN CORSO';
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
                            deadline:
                                DateTime.now().add(const Duration(seconds: 5)),
                          )),
                    ],
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
