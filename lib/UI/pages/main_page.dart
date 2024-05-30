import 'package:app/UI/pages/data_page.dart';
import 'package:app/UI/pages/exam_page.dart';
import 'package:app/UI/pages/home_page.dart';
import 'package:app/UI/pages/home_quiz_page.dart';
import 'package:app/UI/pages/tomato_method.dart';
import 'package:app/domain/utente.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    MyHomePage(),
    TomatoMethod(),
    data_page(),
    HomeQuizPage(),
    Exam_page(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.353),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_rounded,
              color: Colors.black,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.quiz_outlined,
              color: Colors.black,
            ),
            label: 'Quiz',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search_outlined,
              color: Colors.black,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.folder,
              color: Colors.black,
            ),
            label: 'Esami',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
