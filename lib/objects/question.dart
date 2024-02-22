class Question {
  int? idQuiz;
  int? id;
  String text;
  String answer;

  Question(
      {required this.idQuiz,
      this.id,
      required this.text,
      required this.answer});

  Map<String, dynamic> toMap() {
    return {'text': text, 'idQuiz': idQuiz, 'answer': answer};
  }
}
