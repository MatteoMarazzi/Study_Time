import 'package:app/objects/timer.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class TomatoMethod extends StatefulWidget {
  const TomatoMethod({super.key});

  @override
  State<TomatoMethod> createState() => _TomatoMethodState();
}

class _TomatoMethodState extends State<TomatoMethod> {
  late Timer selectedTimer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 155, 17, 7),
        title: Text("METODO DEL POMODORO"),
        centerTitle: true,
      ),
      body: Column(
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
                      'IMPOSTA IL TUO TIMER:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(bottom: 20),
                      child: TomatoTimer(
                        deadline: DateTime.now().add(const Duration(hours: 3)),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
