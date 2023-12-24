import 'package:flutter/material.dart';

// ignore: must_be_immutable
class QuizTile extends StatelessWidget {
  final String quizName;
  VoidCallback OnOpenQuiz;
  QuizTile({super.key, required this.quizName, required this.OnOpenQuiz});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: OnOpenQuiz,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Container(
          padding: EdgeInsets.all(20),
          width: 400,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.deepOrange,
            borderRadius: BorderRadius.circular(5)
          ),
          child: 
            Text(quizName)
        ),
      )
    ); 
  }
}
