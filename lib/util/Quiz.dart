import 'package:app/util/question.dart';
import 'package:flutter/rendering.dart';

class Quiz {
  String nome;
  int id;
  String descrizione;
  Color quizColor;
  late List<Question> domande;

  Quiz(
      {required this.nome,
      required this.id,
      required this.descrizione,
      required this.quizColor});

  static Quiz fromMap(Map<String, dynamic> map) => Quiz(
      nome: map["nome"],
      id: map["id"],
      descrizione: map["descrizione"],
      quizColor: map["quizColor"]);

  Map<String, dynamic> toMap() => {
        "name": nome,
        "id": id,
      };
}
