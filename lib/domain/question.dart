class Question {
  String text;
  String answer;

  Question({required this.text, required this.answer});

  Map<String, dynamic> toMap() {
    return {'text': text, 'answer': answer};
  }
}
