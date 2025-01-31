import 'package:app/UI/util/bar_button.dart';
import 'package:app/UI/pages/data_page.dart';
import 'package:app/UI/pages/exam_page.dart';
import 'package:app/UI/pages/home_page.dart';
import 'package:app/UI/pages/tomato_method.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  static Color colorBar = const Color.fromRGBO(255, 255, 255, 0.353);
  const BottomBar({super.key});
  //List <Widget> destinations = [MyHomePage(),TomatoMethod(),data_page(),HomeQuizPage(),Exam_page()];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black, width: 0.5))),
      child: const BottomAppBar(
        elevation: 20,
        shadowColor: Color.fromARGB(255, 255, 255, 255), //scegli colore ombra
        // color: colorBar,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            BarButton(
              color: Color.fromARGB(255, 0, 0, 0),
              icon: Icons.home_rounded,
              destination: MyHomePage(),
            ),
            BarButton(
              color: Color.fromARGB(255, 0, 0, 0),
              icon: Icons.search_outlined,
              destination: TomatoMethod(),
            ), //NON DEFINITO, da cambiare anche icona
            BarButton(
              color: Color.fromARGB(255, 0, 0, 0),
              icon: Icons.bar_chart_sharp,
              destination: DataPage(),
            ),
            BarButton(
              color: Color.fromARGB(255, 0, 0, 0),
              icon: Icons.folder,
              destination: ExamPage(),
            ),
          ],
        ),
      ),
    );
  }
}
