import 'package:app/UI/pages/home_quiz_page.dart';
import 'package:app/UI/tiles/quiz_tile.dart';
import 'package:app/UI/util/bottom_bar.dart';
import 'package:app/UI/util/calendar.dart';
import 'package:app/UI/tiles/home_tile.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Exam_page extends StatefulWidget {
  const Exam_page({super.key});

  @override
  State<Exam_page> createState() => _Exam_pageState();
}

class _Exam_pageState extends State<Exam_page> {
  List<DateTime?> _selectedCalendarValues = [];
  @override
  Widget build(BuildContext _context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(175, 238, 238, 1.0),
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          title: Text(
            'I MIEI ESAMI',
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          ),
          centerTitle: true,
          actions: [
            CalendarWidget(
              onCalendarChanged: (_selectedCalendarValues) {},
            )
          ]),
      body: Column(children: [
        /*Container(
            child: Lottie.asset('assets/study.json'),
          ),*/
      ]),
      bottomNavigationBar: BottomBar(),
    );
  }
}
