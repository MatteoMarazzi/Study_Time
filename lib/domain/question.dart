class Question {
  int id;
  String text;
  String answer;

  Question({required this.id, required this.text, required this.answer});

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
