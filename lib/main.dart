import 'package:app/UI/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [
        Locale('en', ''),
        Locale('zh', ''),
        Locale('he', ''),
        Locale('es', ''),
        Locale('ru', ''),
        Locale('ko', ''),
        Locale('hi', ''),
      ],
      home: MainPage(),
      builder: (context, child) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.black, // Colore della barra di stato
            statusBarIconBrightness:
                Brightness.light, // Luminosità delle icone della barra di stato
          ),
          child: child!,
        );
      },
    );
  }
}
class MainPage extends StatefulWidget {
  @ovveride
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
int _selectIndex = 0;

 final List <Widget> _pages = [ //lista pagine della bottom bar
  MyHomePage(),
  TomatoMethod(),
  data_page(),
  HomeQuizPage(),
  Exam_page()
 ]

 void _onItemTapped(int index){
  setState(() {
    _selectIndex = index;
  });
 }

@ovveride
Widget build (BuildContext context){
  return Scaffold(
    body:IndexStack(
      index: _selectIndex,
      children: _pages,
    ),
    bottomNavigationBar : BottomBar(); //da modificare, manca l'aggiornamento dello stato
  );
}


}