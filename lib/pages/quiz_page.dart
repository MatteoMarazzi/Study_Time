import 'package:app/pages/flashcards_editor_page.dart';
import 'package:app/pages/quiz_execution_page.dart';
import 'package:app/util/common_functions.dart';
import 'package:app/tiles/flashcard_tile.dart';
import 'package:app/util/review_notification_toggle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  QuizPage({super.key, required this.quiz});

  final QueryDocumentSnapshot<Map<String, dynamic>> quiz;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final questionTextController = TextEditingController();
  final answerTextController = TextEditingController();
  late bool _reviewEnabled = false;

  @override
  void initState() {
    super.initState();
    _reviewEnabled = widget.quiz.data()['reviewEnabled'] as bool? ?? false;
  }

  Future<void> uploadFlashcardToDb() async {
    try {
      await FirebaseFirestore.instance
          .collection("quizzes")
          .doc(widget.quiz.id)
          .collection('flashcards')
          .add({
        "creator": FirebaseAuth.instance.currentUser!.uid,
        "question": questionTextController.text.trim(),
        "answer": answerTextController.text.trim(),
        "difficulty": difficultyToInt(Difficulty.nonValutata)
      });
      questionTextController.clear();
      answerTextController.clear();
      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }
  }

  void createFlashcard() async {
    questionTextController.clear();
    answerTextController.clear();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FlashcardsEditorPage(
                  questionController: questionTextController,
                  answerController: answerTextController,
                  onSalva: uploadFlashcardToDb,
                  onAnnulla: () => Navigator.of(context).pop(),
                )));
  }

  deleteFlashcard(String flashcardToDelete) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Conferma eliminazione'),
          content:
              const Text('Sei sicuro di voler eliminare questa flashcard?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annulla'),
            ),
            TextButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection("quizzes")
                    .doc(widget.quiz.id)
                    .collection('flashcards')
                    .doc(flashcardToDelete)
                    .delete();
                setState(() {});
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
              child: const Text('Elimina', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  modifyFlashcard(
      QueryDocumentSnapshot<Map<String, dynamic>> flashcardToModify) async {
    Navigator.pop(context);
    questionTextController.text = flashcardToModify.data()['question'];
    answerTextController.text = flashcardToModify.data()['answer'];
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FlashcardsEditorPage(
                  questionController: questionTextController,
                  answerController: answerTextController,
                  onSalva: () async {
                    await FirebaseFirestore.instance
                        .collection("quizzes")
                        .doc(widget.quiz.id)
                        .collection('flashcards')
                        .doc(flashcardToModify.id)
                        .update({
                      'question': questionTextController.text,
                      'answer': answerTextController.text
                    });
                    questionTextController.clear();
                    answerTextController.clear();
                    setState(() {
                      Navigator.of(context).pop();
                    });
                  },
                  onAnnulla: () => Navigator.of(context).pop(),
                )));
  }

  startQuiz(int flashcardsCount) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QuizExecutionPage(
                  quiz: widget.quiz,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('quizzes')
            .doc(widget.quiz.id)
            .collection('flashcards')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final flashcards =
              snapshot.data!.docs.map((doc) => doc.data()).toList();

          final easyFlashcards = flashcards
              .where(
                  (q) => intToDifficulty(q['difficulty']) == Difficulty.facile)
              .length;
          final difficultFlashcards = flashcards
              .where((q) =>
                  intToDifficulty(q['difficulty']) == Difficulty.difficile)
              .length;
          final newFlashcards = flashcards
              .where((q) =>
                  intToDifficulty(q['difficulty']) == Difficulty.nonValutata)
              .length;
          final flashcardsCount = flashcards.length;
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
              title: Text(widget.quiz.data()['name'],
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      //decoration: TextDecoration.underline,
                      decorationThickness: 1)),
              centerTitle: true,
              actions: [
                ReviewNotificationToggle(
                  quizId: widget.quiz.id,
                  initialValue: _reviewEnabled,
                ),
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    (widget.quiz.data()['description'] as String?)
                                ?.trim()
                                .isNotEmpty ==
                            true
                        ? (widget.quiz.data()['description'] as String)
                        : 'Ancora nessuna descrizione',
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, left: 30),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dati Flashcards',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                LegendItem(
                                  color: difficultyToColor(Difficulty.facile),
                                  text: "Facili: $easyFlashcards",
                                ),
                                LegendItem(
                                  color:
                                      difficultyToColor(Difficulty.difficile),
                                  text: "Difficili: $difficultFlashcards",
                                ),
                                LegendItem(
                                  color:
                                      difficultyToColor(Difficulty.nonValutata),
                                  text: "Nuove: $newFlashcards",
                                ),
                              ]),
                        )),
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        height: 200,
                        child: PieChart(
                          PieChartData(
                            sections: [
                              PieChartSectionData(
                                value: flashcardsCount > 0
                                    ? (easyFlashcards / flashcardsCount) * 100
                                    : 0,
                                title: flashcardsCount > 0
                                    ? '${((easyFlashcards / flashcardsCount) * 100).toInt()}%'
                                    : '0%',
                                color: difficultyToColor(Difficulty.facile),
                                radius: 80,
                                titleStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              PieChartSectionData(
                                value: flashcardsCount > 0
                                    ? (difficultFlashcards / flashcardsCount) *
                                        100
                                    : 0,
                                title: flashcardsCount > 0
                                    ? '${((difficultFlashcards / flashcardsCount) * 100).toInt()}%'
                                    : '0%',
                                color: difficultyToColor(Difficulty.difficile),
                                radius: 80,
                                titleStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              PieChartSectionData(
                                value: flashcardsCount > 0
                                    ? (newFlashcards / flashcardsCount) * 100
                                    : 0,
                                title: flashcardsCount > 0
                                    ? '${((newFlashcards / flashcardsCount) * 100).toInt()}%'
                                    : '0%',
                                color:
                                    difficultyToColor(Difficulty.nonValutata),
                                radius: 80,
                                titleStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              PieChartSectionData(
                                //caso no flashcards
                                value: flashcardsCount == 0 ? 100 : 0,
                                title: "",
                                color:
                                    difficultyToColor(Difficulty.nonValutata),
                                radius: 80,
                              )
                            ],
                            borderData: FlBorderData(show: false),
                            centerSpaceRadius: 0,
                            sectionsSpace: 4,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 33, top: 15),
                    child: Text(
                      '${flashcardsCount} Flashcards',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 1,
                      childAspectRatio: 2.3,
                    ),
                    padding: const EdgeInsets.all(8),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var flashcardDoc = snapshot.data!.docs[index];
                      return FlashcardTile(
                        questionText: flashcardDoc.data()['question'],
                        color: difficultyToColor(
                            intToDifficulty(flashcardDoc.data()['difficulty'])),
                        onOpenElimina: () => deleteFlashcard(flashcardDoc.id),
                        onOpenModifica: () => modifyFlashcard(flashcardDoc),
                      );
                    },
                  ),
                ),
              ],
            ),
            floatingActionButton: Container(
              margin: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton(
                    heroTag: '2',
                    onPressed: createFlashcard,
                    backgroundColor: Colors.white,
                    child: const Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 16),
                  FloatingActionButton(
                    heroTag: '3',
                    onPressed: () async {
                      flashcardsCount > 0 ? startQuiz(flashcardsCount) : null;
                    },
                    backgroundColor:
                        flashcardsCount > 0 ? Colors.white : Colors.grey,
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const LegendItem({Key? key, required this.color, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.rectangle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
