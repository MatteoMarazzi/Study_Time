import 'package:app/UI/pages/flashcards_editor_page.dart';
import 'package:app/UI/pages/quiz_execution_page.dart';
import 'package:app/domain/flashcard.dart';
import 'package:app/domain/quiz.dart';
import 'package:app/UI/tiles/flashcard_tile.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class QuizPage extends StatefulWidget {
  QuizPage({super.key, required this.title, required this.quiz});

  final String title;
  Quiz quiz;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final questionTextController = TextEditingController();
  final answerTextController = TextEditingController();

  void saveFlashcard() async {
    widget.quiz.addFlashcard(
      question: questionTextController.text,
      answer: answerTextController.text,
    );
    setState(() {});
    questionTextController.clear();
    answerTextController.clear();
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  void createFlashcard() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FlashcardsEditorPage(
                  questionController: questionTextController,
                  answerController: answerTextController,
                  onSalva: saveFlashcard,
                  onAnnulla: () => Navigator.of(context).pop(),
                )));
  }

  deleteFlashcard(Flashcard questionToDelete) {
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
                widget.quiz.deleteFlashcard(questionToDelete);
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

  modifyFlashcard(Flashcard questionToModify) async {
    questionTextController.text = questionToModify.question;
    answerTextController.text = questionToModify.answer;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FlashcardsEditorPage(
                  questionController: questionTextController,
                  answerController: answerTextController,
                  onSalva: () async {
                    /*await*/ widget.quiz.updateFlashcard(
                        questionTextController.text,
                        answerTextController.text,
                        questionToModify);
                    questionTextController.clear();
                    answerTextController.clear();
                    setState(() {
                      Navigator.of(context).pop();
                    });
                  },
                  onAnnulla: () => Navigator.of(context).pop(),
                )));
  }

  startQuiz() async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QuizExecutionPage(
                  quiz: widget.quiz,
                )));
  }

  @override
  Widget build(BuildContext context) {
    int easyFlashcards = widget.quiz.flashcardsList
        .where((q) => q.difficulty == Difficulty.facile)
        .length;
    int difficultFlashcards = widget.quiz.flashcardsList
        .where((q) => q.difficulty == Difficulty.difficile)
        .length;
    int newFlashcards = widget.quiz.flashcardsList
        .where((q) => q.difficulty == Difficulty.nonValutata)
        .length;
    int totalFlashcards = widget.quiz.flashcardsList.length;
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
        title: Text(widget.title, style: const TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: totalFlashcards > 0
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: widget.quiz.description.isEmpty
                      ? const Text(
                          'Nessuna descrizione',
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                        )
                      : Text(
                          widget.quiz.description,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                ),
                SizedBox(
                  height: 40,
                ),
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
                                  color: Colors.green,
                                  text: "Facili: $easyFlashcards",
                                ),
                                LegendItem(
                                  color: Colors.red,
                                  text: "Difficili: $difficultFlashcards",
                                ),
                                LegendItem(
                                  color: Colors.grey,
                                  text: "Nuove: $newFlashcards",
                                ),
                              ]),
                        )),
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                          height: 200,
                          child: PieChart(PieChartData(
                            sections: [
                              PieChartSectionData(
                                value: (easyFlashcards / totalFlashcards) * 100,
                                title:
                                    '${((easyFlashcards / totalFlashcards) * 100).toInt()}%',
                                color: Colors.green,
                                radius: 80,
                                titleStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              PieChartSectionData(
                                value: (difficultFlashcards / totalFlashcards) *
                                    100,
                                title:
                                    '${((difficultFlashcards / totalFlashcards) * 100).toInt()}%',
                                color: Colors.red,
                                radius: 80,
                                titleStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              PieChartSectionData(
                                value: (newFlashcards / totalFlashcards) * 100,
                                title:
                                    '${((newFlashcards / totalFlashcards) * 100).toInt()}%',
                                color: Colors.grey,
                                radius: 80,
                                titleStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                            borderData:
                                FlBorderData(show: false), // Nessun bordo
                            centerSpaceRadius:
                                0, // Raggio dello spazio centrale
                            sectionsSpace: 4, // Spazio tra le sezioni)),
                          ))),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 33, top: 15),
                    child: Text(
                      '${totalFlashcards} Flashcards',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.8,
                    ),
                    padding: const EdgeInsets.all(8),
                    itemCount: widget.quiz.flashcardsList.length,
                    itemBuilder: (context, index) {
                      Flashcard? currentFlashcard =
                          widget.quiz.flashcardsList[index];
                      return FlashcardTile(
                        questionText: currentFlashcard.question,
                        color: widget.quiz.color,
                        onOpenElimina: () => deleteFlashcard(currentFlashcard),
                        onOpenModifica: () => modifyFlashcard(currentFlashcard),
                      );
                    },
                  ),
                ),
              ],
            )
          : Center(
              child: Text(
                'Nessun dato disponibile per il grafico',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
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
              onPressed: widget.quiz.flashcardsList.isEmpty ? null : startQuiz,
              backgroundColor: widget.quiz.flashcardsList.isEmpty
                  ? Colors.grey
                  : Colors.white,
              child: const Icon(
                Icons.play_arrow,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
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
