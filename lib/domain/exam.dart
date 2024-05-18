import 'package:app/domain/quiz.dart';
import 'package:uuid/uuid.dart';

class Exam {
  late String id;
  Map<String, Quiz> quizzesMap = {};
  List<Quiz> quizzesList = [];

  Exam() {
    id = const Uuid().v4();
  }

  Quiz? getQuiz(dynamic identifier) {
    if (identifier is String) {
      return quizzesMap[identifier];
    } else if (identifier is int) {
      if (identifier >= 0 && identifier < quizzesList.length) {
        return quizzesList[identifier];
      }
    }
    return null;
  }

  int countQuizzes() {
    return quizzesMap.length;
  }
}
