import 'package:app/objects/question.dart';

class Quiz {
  String nome;
  int id;
  late List<Question> domande;

  Quiz({required this.nome, required this.id});

  static Quiz fromMap(Map<String, dynamic> map) =>
      Quiz(nome: map["nome"], id: map["id"]);

  Map<String, dynamic> toMap() => {"name": nome, "id": id};
}
