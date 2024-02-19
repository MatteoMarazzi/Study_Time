import 'package:app/objects/answer.dart';

class Question {
  int? idQuiz;
  int? id;
  String text;
  late String answer;

  Question({required this.idQuiz, this.id, required this.text});

  Map<String, dynamic> toMap() {
    return {'text': text, 'idQuiz': idQuiz};
  }
}
