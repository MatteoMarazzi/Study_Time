import 'package:app/UI/util/flashcard.dart';
import 'package:app/domain/quiz.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class QuizExecutionPage extends StatefulWidget {
  final Quiz quiz;
  const QuizExecutionPage({super.key, required this.quiz});

  @override
  State<QuizExecutionPage> createState() => _QuizExecutionPageState();
}

int currentIndex = 0;

class _QuizExecutionPageState extends State<QuizExecutionPage> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flashcard Quiz'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(2, 67, 69, 1),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 350,
              height: 450,
              child: FlipCard(
                key: cardKey,
                flipOnTouch: true,
                front: Flashcard(
                  text: widget.quiz.questionsList[currentIndex].text,
                ),
                back: Flashcard(
                  text: widget.quiz.questionsList[currentIndex].answer,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton.icon(
                  onPressed: previousCard,
                  icon: Icon(Icons.chevron_left),
                  label: Text('Prev'),
                ),
                OutlinedButton.icon(
                  onPressed: nextCard,
                  icon: Icon(Icons.chevron_right),
                  label: Text('Next'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void previousCard() {
    setState(() {
      currentIndex = (currentIndex - 1 >= 0)
          ? currentIndex - 1
          : widget.quiz.questionsList.length - 1;
      cardKey = GlobalKey<FlipCardState>();
    });
  }

  void nextCard() {
    setState(() {
      currentIndex = (currentIndex + 1 < widget.quiz.questionsList.length)
          ? currentIndex + 1
          : 0;
      cardKey = GlobalKey<FlipCardState>();
    });
  }
}
