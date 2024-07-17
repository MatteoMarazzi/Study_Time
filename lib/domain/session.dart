import 'package:app/databases/sessionsDB.dart';

class Session {
  final int id;
  String title;
  int minutiStudio;
  int minutiPausa;
  int ripetizioni;

  Session(
      {required this.title,
      required this.minutiStudio,
      required this.minutiPausa,
      required this.ripetizioni,
      required this.id});

  Future update(
      int newMinutiStudio, int newMinutiPausa, int newRipetizioni) async {
    minutiStudio = newMinutiStudio;
    minutiPausa = newMinutiPausa;
    ripetizioni = newRipetizioni;
    await SessionsDatabase().updateSession(this);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'minuti_studio': minutiStudio,
      'minuti_pausa': minutiPausa,
      'ripetizioni': ripetizioni,
    };
  }

  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      id: map['id'],
      title: map['title'],
      minutiStudio: map['minuti_studio'],
      minutiPausa: map['minuti_pausa'],
      ripetizioni: map['ripetizioni'],
    );
  }
}
