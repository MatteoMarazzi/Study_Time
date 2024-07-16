import 'package:app/domain/session.dart';
import 'package:flutter/material.dart';

class SessionTile extends StatelessWidget {
  final String title;
  final Session session;
  final String? consiglio;
  final Color color;

  const SessionTile(
      {super.key,
      required this.title,
      required this.session,
      required this.color,
      this.consiglio});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
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
          color: const Color.fromARGB(239, 255, 255, 255),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(2),
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 4),
              child: Row(
                children: [
                  const Text(
                    'Minuti di studio :',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                  Text(
                    '  ${session.minutiStudio} min',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 4),
              child: Row(
                children: [
                  const Text(
                    'Minuti di pausa :',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                  Text(
                    '  ${session.minutiPausa} min',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 4),
              child: Row(
                children: [
                  const Text(
                    'Ripetuto per :',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                  Text(
                    '  ${session.ripetizioni} volte',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5, top: 7),
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
    );
  }
}
