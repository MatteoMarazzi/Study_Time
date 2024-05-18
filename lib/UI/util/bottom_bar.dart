import 'package:app/UI/util/bar_button.dart';
import 'package:app/UI/pages/data_page.dart';
import 'package:app/UI/pages/exam_page.dart';
import 'package:app/UI/pages/home_page.dart';
import 'package:app/UI/pages/home_quiz_page.dart';
import 'package:app/UI/pages/tomato_method.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  static const Color colorBar = Color.fromRGBO(255, 255, 255, 0.353);
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black, width: 0.5))),
      child: const BottomAppBar(
        elevation: 20,
        shadowColor: Color.fromARGB(255, 255, 255, 255), //scegli colore ombra
        color: colorBar,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            bar_Button(
              color: Color.fromARGB(255, 0, 0, 0),
              icon: Icons.home_rounded,
              destination: MyHomePage(),
            ),
            bar_Button(
              color: Color.fromARGB(255, 0, 0, 0),
              icon: Icons.search_outlined,
              destination: TomatoMethod(),
            ), //NON DEFINITO, da cambiare anche icona
            bar_Button(
              color: Color.fromARGB(255, 0, 0, 0),
              icon: Icons.bar_chart_sharp,
              destination: data_page(),
            ),
            bar_Button(
              color: Color.fromARGB(255, 0, 0, 0),
              icon: Icons.folder,
              destination: Exam_page(),
            ),
          ],
        ),
      ),
    );
  }
}
