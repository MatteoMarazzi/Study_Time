import 'package:app/domain/quiz.dart';
import 'package:flutter/material.dart';

class QuizExecutionPage extends StatefulWidget {
  final Quiz quiz;
  const QuizExecutionPage({super.key, required this.quiz});

  @override
  State<QuizExecutionPage> createState() => _QuizExecutionPageState();
}

class _QuizExecutionPageState extends State<QuizExecutionPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
