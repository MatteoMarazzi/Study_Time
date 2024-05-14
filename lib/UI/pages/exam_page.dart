import 'package:app/UI/pages/home_quiz_page.dart';
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
            backgroundColor: const Color.fromRGBO(2, 67, 69, 1),
            title: Text(
              'ESAMI',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            actions: [
              CalendarWidget(
                onCalendarChanged: (_selectedCalendarValues) {},
              )
            ]),
        body: Column(children: [
          Container(
            child: Lottie.asset('assets/study.json'),
          ),
          Home_tile(
              standard: 1,
              //FATTO ALLA CAVOLO, DA ELIMINARE DA QUI IN GIU
              color: Colors.black,
              shadow_color: Colors.transparent,
              backgroundColor: Colors.purple,
              destinationPage: HomeQuizPage(),
              boxTitle: 'ESAME 1',
              pathImage: 'assets/allarm_clock.png',
              heightImage: 130,
              weightImage: 250)
        ]));
  }
}
