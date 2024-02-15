import 'package:flutter/material.dart';

class bar_Button extends StatelessWidget {
  final Color color;
  final IconData icon;
  final Widget destination;

  const bar_Button(
      {super.key,
      required this.color,
      required this.icon,
      required this.destination});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  destination), // Utilizziamo il widget destinazione per la navigazione
        );
      },
      color: Colors.white,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    );
  }
}
