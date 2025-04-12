import 'package:flutter/material.dart';

String rgbToHex(Color color) {
  return '${color.red.toRadixString(16).padLeft(2, '0')}${color.green.toRadixString(16).padLeft(2, '0')}${color.blue.toRadixString(16).padLeft(2, '0')}';
}

Color hexToColor(String hex) {
  return Color(int.parse(hex, radix: 16) + 0xFF000000);
}

enum Difficulty { facile, difficile, nonValutata }

int difficultyToInt(Difficulty difficulty) {
  return difficulty.index;
}

Difficulty intToDifficulty(int value) {
  return Difficulty.values[value];
}

String difficultyToString(Difficulty difficulty) {
  switch (difficulty) {
    case Difficulty.facile:
      return 'Facile';
    case Difficulty.difficile:
      return 'Difficile';
    case Difficulty.nonValutata:
      return 'Nuova';
  }
}

Color difficultyToColor(Difficulty difficulty) {
  switch (difficulty) {
    case Difficulty.facile:
      return Colors.green;
    case Difficulty.difficile:
      return Colors.red;
    case Difficulty.nonValutata:
      return Colors.grey;
  }
}
