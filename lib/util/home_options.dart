import 'package:flutter/material.dart';

class RoundedRectangle extends StatelessWidget {
  final Color color;
  final Color backgroundColor; // Aggiungiamo il colore di sfondo
  final Widget destinationPage; // Correggo il tipo del parametro

  const RoundedRectangle({
    Key? key,
    required this.color,
    required this.backgroundColor, // Aggiorniamo il costruttore
    required this.destinationPage, // Aggiorniamo il costruttore con il widget destinazione
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage), // Utilizziamo il widget destinazione per la navigazione
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15), 
      child: Row(
      children : [
        Expanded(
          child: Container(
        width: 325, // Bordo esterno larghezza
        height: 80, // Bordo esterno altezza
        decoration: BoxDecoration(
          color: backgroundColor, // Utilizziamo il colore di sfondo
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Container(
            width: 310, // Bordo interno larghezza
            height: 20, // Bordo interno altezza
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
        )
      ],
      )
      )
    );
  }
}