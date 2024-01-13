import 'package:app/util/calendar.dart';
import 'package:flutter/material.dart';

class Exam_page extends StatelessWidget {
  const Exam_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(175, 238, 238, 1.0),
      appBar: AppBar(
          backgroundColor: const Color.fromRGBO(2, 67, 69, 1),
          title: Text(
            'ESAMI',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: [calendar()]),
    );
  }
}
