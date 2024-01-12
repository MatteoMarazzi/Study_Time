import 'package:flutter/material.dart';

class tomato extends StatefulWidget {
  const tomato({super.key});

  @override
  State<tomato> createState() => _tomatoState();
}



class _tomatoState extends State<tomato> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Color.fromARGB(255, 155, 17, 7),
        title: Text("METODO DEL POMODORO"),
      
      ),
    );
  }
}