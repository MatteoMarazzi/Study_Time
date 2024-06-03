import 'package:flutter/material.dart';

class BarButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final Widget destination;

  const BarButton(
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
      color: color,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    );
  }
}
