import 'package:flutter/material.dart';
import 'dart:async';

class ClockWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Stream<DateTime> clockStream = Stream.periodic(Duration(seconds: 1), (_) => DateTime.now());
    
    return StreamBuilder<DateTime>(
      stream: clockStream,
      builder: (BuildContext context, AsyncSnapshot<DateTime> snapshot) {
        if (snapshot.hasData) {
          DateTime currentTime = snapshot.data!;
          return Text(
            '${currentTime.hour}:${currentTime.minute}:${currentTime.second}',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          );
        } else {
          return CircularProgressIndicator(); // Mostra un indicatore di caricamento finché non arriva il primo dato.
        }
      },
    );
  }
}