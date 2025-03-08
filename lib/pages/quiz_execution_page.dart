import 'package:app/util/common_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class QuizExecutionPage extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> quiz;
  final int flashcardsCount;
  const QuizExecutionPage(
      {super.key, required this.quiz, required this.flashcardsCount});

  @override
  State<QuizExecutionPage> createState() => _QuizExecutionPageState();
}

int currentIndex = 0;

class _QuizExecutionPageState extends State<QuizExecutionPage> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('quizzes')
            .doc(widget.quiz.id)
            .collection('flashcards')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Nessuna flashcard trovata"));
          }
          final flashcards = snapshot.data!.docs;
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  )),
              centerTitle: true,
              title: Text('${widget.quiz.data()['name']}',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.black)),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 350,
                    height: 600,
                    child: FlipCard(
                      key: cardKey,
                      flipOnTouch: true,
                      front: Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 8.0,
                                left: 8.0,
                                child: Text(
                                  '${difficultyToString(intToDifficulty(flashcards[currentIndex].data()['difficulty']))}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Positioned(
                                top: 8.0,
                                right: 8.0,
                                child: Text(
                                  'Flashcard ${currentIndex + 1} di ${widget.flashcardsCount}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Center(
                                child: Text(
                                  snapshot.data!.docs[currentIndex]
                                      .data()['question'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 19),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      back: Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Center(
                            child: Text(
                              snapshot.data!.docs[currentIndex]
                                  .data()['answer'],
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 19),
                            ),
                          ),
                        ),
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
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection("quizzes")
                                  .doc(widget.quiz.id)
                                  .collection('flashcards')
                                  .doc(snapshot.data!.docs[currentIndex].id)
                                  .update({
                                'difficulty':
                                    difficultyToInt(Difficulty.difficile)
                              });
                              nextCard();
                            },
                            style: ButtonStyle(
                              animationDuration: const Duration(seconds: 5),
                              overlayColor:
                                  MaterialStateProperty.all(Colors.grey),
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
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection("quizzes")
                                  .doc(widget.quiz.id)
                                  .collection('flashcards')
                                  .doc(snapshot.data!.docs[currentIndex].id)
                                  .update({
                                'difficulty': difficultyToInt(Difficulty.facile)
                              });
                              nextCard();
                            },
                            style: ButtonStyle(
                              animationDuration: const Duration(seconds: 5),
                              overlayColor:
                                  MaterialStateProperty.all(Colors.grey),
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
        });
  }

  void previousCard() {
    setState(() {
      currentIndex = (currentIndex - 1 >= 0)
          ? currentIndex - 1
          : widget.flashcardsCount - 1;
      cardKey = GlobalKey<FlipCardState>();
    });
  }

  void nextCard() {
    setState(() {
      currentIndex =
          (currentIndex + 1 < widget.flashcardsCount) ? currentIndex + 1 : 0;
      cardKey = GlobalKey<FlipCardState>();
    });
  }
}
