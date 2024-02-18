import 'package:app/objects/answer.dart';

class Question {
  int? id;
  String text;
  late List<Answer> answers;

  Question({this.id, required this.text});

  Map<String, dynamic> toMap() {
    return {'text': text};
  }
}
