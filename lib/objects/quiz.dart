import 'package:app/objects/question.dart';
import 'package:flutter/material.dart';

class Quiz {
  int? id;
  String name;
  String description;
  late List<Question> domande;

  Quiz({
    this.id,
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
    };
  }
}
