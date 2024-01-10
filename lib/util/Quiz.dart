
import 'package:app/util/Domanda.dart';

class Quiz{
  String nome;
  int id;
  late List<Domanda> domande;

  Quiz({required this.nome,required this.id});

  static Quiz fromMap(Map<String,dynamic> map) =>
  Quiz(nome : map["nome"], id: map["id"]);

  Map<String, dynamic> toMap() => {
    "name" : nome,
    "id" : id
  };
}