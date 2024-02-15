import 'package:app/objects/bar_button.dart';
import 'package:app/pages/data_page.dart';
import 'package:app/pages/exam_page.dart';
import 'package:app/pages/home_page.dart';
import 'package:app/pages/home_quiz_page.dart';
import 'package:app/pages/tomato_method.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  static const Color colorBar = const Color.fromARGB(255, 0, 105, 4);
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const BottomAppBar(
      color: colorBar,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          bar_Button(
            color: const Color.fromRGBO(255, 255, 255, 1),
            icon: Icons.home_rounded,
            destination: MyHomePage(),
          ),
          bar_Button(
            color: const Color.fromRGBO(255, 255, 255, 1),
            icon: Icons.search_outlined,
            destination: TomatoMethod(),
          ), //NON DEFINITO, da cambiare anche icona
          bar_Button(
            color: const Color.fromRGBO(255, 255, 255, 1),
            icon: Icons.bar_chart_sharp,
            destination: data_page(),
          ),
          bar_Button(
            color: const Color.fromRGBO(255, 255, 255, 1),
            icon: Icons.quiz_outlined,
            destination: HomeQuizPage(),
          ),
          bar_Button(
            color: const Color.fromRGBO(255, 255, 255, 1),
            icon: Icons.folder,
            destination: Exam_page(),
          ),
        ],
      ),
    );
  }
}
