import 'package:app/UI/util/bottom_bar.dart';
import 'package:app/UI/util/calendar.dart';
import 'package:flutter/material.dart';

class ExamPage extends StatefulWidget {
  const ExamPage({super.key});

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  //List<DateTime?> _selectedCalendarValues = [];
  @override
  Widget build(BuildContext context) {
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
