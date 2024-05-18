import 'package:uuid/uuid.dart';

class Question {
  late String id;
  String text;
  String answer;

  Question({required this.text, required this.answer}) {
    id = const Uuid().v4();
  }

  Map<String, dynamic> toMap() {
    return {'text': text, 'answer': answer};
  }

  String getText() {
    return text;
  }

  String getAnswer() {
    return answer;
  }
}
