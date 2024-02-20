import 'package:app/pages/study_session.dart';
import 'package:flutter/material.dart';

class sessionTile extends StatelessWidget {
  final String title;
  final int studio;
  final int pausa;
  final int volte;
  final String? consiglio;
  final Color color;
  final bool canModifyValues;

  const sessionTile(
      {super.key,
      required this.title,
      required this.studio,
      required this.pausa,
      required this.volte,
      required this.color,
      required this.canModifyValues,
      this.consiglio});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => studySession(
                    studio: studio,
                    pausa: pausa,
                    volte: volte,
                    canModifyValues: canModifyValues,
                  )), // Utilizziamo il widget destinazione per la navigazione
        );
      },
      child: Padding(
        padding: EdgeInsets.only(
            left: screenSize.width * 0.04,
            right: screenSize.width * 0.04,
            top: screenSize.height * 0.04),
        child: Container(
          width: 500,
          height: 125,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.black, // colore dell'ombra
                blurRadius: 3, // raggio di sfocatura
                spreadRadius: 0.5, // raggio di diffusione
              ),
            ],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1.3, color: color),
            color: Color.fromARGB(239, 255, 255, 255),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(2),
                child: Center(
                  child: Text(
                    '$title',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 4),
                child: Row(
                  children: [
                    Text(
                      'Minuti di studio :',
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    Text(
                      '  $studio min',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 4),
                child: Row(
                  children: [
                    Text(
                      'Minuti di pausa :',
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    Text(
                      '  $pausa min',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 4),
                child: Row(
                  children: [
                    Text(
                      'Ripetuto per :',
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    Text(
                      '  $volte volte',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 7),
                child: Row(
                  children: [
                    Text(
                      'Consiglio :',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Da ripetersi più volte durante la giornata',
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
