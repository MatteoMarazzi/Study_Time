import 'package:app/domain/exam.dart';
import 'package:app/domain/quiz.dart';
import 'package:app/domain/utente.dart';

class Controller {
  //static final Controller _instance = Controller._internal();
  late Utente utente;
  late Exam currentExam;
  late Quiz currentQuiz;

  Controller() {
    utente = Utente();
  }
}
