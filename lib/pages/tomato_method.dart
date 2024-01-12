import 'package:flutter/material.dart';

class TomatoMehod extends StatefulWidget {
  const TomatoMehod({super.key});

  @override
  State<TomatoMehod> createState() => _TomatoMehodState();
}

class _TomatoMehodState extends State<TomatoMehod> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 155, 17, 7),
        title: Text("METODO DEL POMODORO"),
      ),
    );
  }
}
