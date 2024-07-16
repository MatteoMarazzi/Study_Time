import 'dart:ui';
import 'package:app/databases/QuizDB.dart';
import 'package:app/databases/sessionsDB.dart';
import 'package:app/domain/quiz.dart';
import 'package:app/domain/session.dart';

class Utente {
  static final Utente _instance = Utente._internal();
  Map<int, Quiz> quizzesMap = {};
  final List<Quiz> quizzesList = [];
  Session standardSession = Session(
      id: 1,
      title: 'standard',
      minutiPausa: 4,
      minutiStudio: 25,
      ripetizioni: 4);
  Session personalizzata1Session = Session(
      id: 2,
      title: 'personalizzata1',
      minutiPausa: 0,
      minutiStudio: 0,
      ripetizioni: 0);
  Session personalizzata2Session = Session(
      id: 3,
      title: "personalizzata2",
      minutiPausa: 0,
      minutiStudio: 0,
      ripetizioni: 0);

  factory Utente() {
    return _instance;
  }

  Utente._internal();

  Future mountDatabase() async {
    quizzesList.addAll(await QuizzesDatabase().getAllQuizzes());
    quizzesMap = {for (var quiz in quizzesList) quiz.id: quiz};
    for (Quiz q in quizzesList) {
      q.mountDatabase();
    }
    standardSession =
        await SessionsDatabase().getSession(standardSession.title);
    personalizzata1Session =
        await SessionsDatabase().getSession(personalizzata1Session.title);
    personalizzata2Session =
        await SessionsDatabase().getSession(personalizzata2Session.title);
  }

  //aggiunta di un nuovo quiz non presente nel database
  Future addQuiz({required name, required description, required color}) async {
    Quiz temp = Quiz(id: 0, name: name, description: description, color: color);
    int genereatedId = await QuizzesDatabase().insertQuiz(temp);
    Quiz newQuiz = Quiz(
        id: genereatedId, name: name, description: description, color: color);
    quizzesList.add(newQuiz);
    quizzesMap[newQuiz.id] = newQuiz;
  }

  Future updateQuiz(
      String newName, String newDescription, Color newColor, Quiz quiz) async {
    await QuizzesDatabase().updateQuiz(newName, newDescription, newColor, quiz);
    Quiz updatedQuiz = Quiz(
        id: quiz.id,
        name: newName,
        description: newDescription,
        color: newColor);
    quizzesMap[quiz.id] = updatedQuiz;
    for (int i = 0; i < quizzesList.length; i++) {
      if (quizzesList[i].id == quiz.id) {
        quizzesList[i] = updatedQuiz;
        break;
      }
    }
  }

  Future updateSession(Session session, int newMinutiStudio, int newMinutiPausa,
      int newRipetizioni) async {
    session.minutiStudio = newMinutiStudio;
    session.minutiPausa = newMinutiPausa;
    session.ripetizioni = newRipetizioni;
    SessionsDatabase().updateSession(session);
  }

  Future deleteQuiz(Quiz quiz) async {
    await QuizzesDatabase().deleteQuiz(quiz);
    quizzesMap.remove(quiz.id);
    quizzesList.remove(quiz);
  }

  Quiz? getQuiz(int index) {
    if (index < 0 || index >= quizzesList.length) {
      return null;
    }
    return quizzesList[index];
  }

  int countQuizzes() {
    return quizzesList.length;
  }
}
