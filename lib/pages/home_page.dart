import 'package:app/pages/home_quiz_page.dart';
import 'package:app/pages/tomato_method.dart';
import 'package:app/util/home_options.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 // int _counter = 0;

 // void _incrementCounter() {
 //   setState(() {
 //     print("Incremento di 2");
 //     _counter = _counter + 2;

 //   });
 // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
         
        backgroundColor: const Color.fromRGBO(2, 67, 69, 1),
        actions: <Widget>[
          IconButton(
             onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  // ignore: prefer_const_constructors
                  builder: (context) => HomeQuizPage(title: "                     QUIZ"),
                  ),
                );
             },
            icon: Image.asset(
              'assets/tomato.png'

            ),
           ),
        ],

        title: Center(
          child : Text(
            widget.title,
            textAlign: TextAlign.center,
            style : TextStyle(color: Colors.white)
          ),
        )
        ),

      // ignore: prefer_const_constructors
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 127, 159, 190),
        ),
      body: Center(
      child : Column(
        children: [
          SizedBox(height: 20),
         RoundedRectangle(
          color: Colors.red,
          backgroundColor: Colors.red,
          destinationPage: tomato(),
         ),
        SizedBox(height: 20),
         RoundedRectangle(color: Colors.yellow, backgroundColor:Colors.yellow,
         destinationPage: HomeQuizPage(title: "QUIZ"),)
        ],
      )
      )
    );
  }
}

