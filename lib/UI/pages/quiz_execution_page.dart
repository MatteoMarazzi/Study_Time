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
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Passing false as result
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('${widget.quiz.name}',
            textAlign: TextAlign.left, style: TextStyle(color: Colors.black)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Flashcard ${currentIndex + 1} di ${widget.quiz.questionsList.length}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 350,
              height: 550,
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
                IconButton(
                  onPressed: previousCard,
                  icon: Icon(Icons.chevron_left),
                ),
                Container(
                  height: 80,
                  width: 120,
                  child: Card(
                    elevation: 5,
                    color: Colors.red,
                    shadowColor: Colors.black,
                    child: TextButton(
                      onPressed: null,
                      style: ButtonStyle(
                        animationDuration: const Duration(seconds: 5),
                        overlayColor: MaterialStateProperty.all(Colors.grey),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Difficile',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 120,
                  height: 80,
                  child: Card(
                    elevation: 5,
                    color: Colors.green,
                    shadowColor: Colors.black,
                    child: TextButton(
                      onPressed: null,
                      style: ButtonStyle(
                        animationDuration: const Duration(seconds: 5),
                        overlayColor: MaterialStateProperty.all(Colors.grey),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Facile',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: nextCard,
                  icon: Icon(Icons.chevron_right),
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
