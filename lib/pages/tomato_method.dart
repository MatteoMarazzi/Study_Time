import 'package:flutter/material.dart';

class TomatoMethod extends StatefulWidget {
  const TomatoMethod({super.key});

  @override
  State<TomatoMethod> createState() => _TomatoMethodState();
}

class _TomatoMethodState extends State<TomatoMethod> {
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
