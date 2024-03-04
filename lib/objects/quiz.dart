import 'dart:ui';

import 'package:app/objects/question.dart';

class Quiz {
  int? id;
  String name;
  String description;
  Color color;
  late List<Question> questions;

  Quiz(
      {this.id,
      required this.name,
      required this.description,
      required this.color});

  Map<String, dynamic> toMap() {
    return {'name': name, 'description': description, 'color': color.toHex()};
  }
}

extension ColorExtension on Color {
  String toHex() {
    return 'FF${value.toRadixString(16).toUpperCase().substring(1)}';
  }
}
