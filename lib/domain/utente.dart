import 'package:app/domain/exam.dart';

class Utente {
  final List<Exam> exams = [];

  Utente();

  Exam addExam({required name, required description}) {
    Exam newExam = Exam(name: name, description: description);
    exams.add(newExam);
    return newExam;
  }
}
