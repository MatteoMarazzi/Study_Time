import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class Tile extends StatelessWidget {
  final String quizName;
  VoidCallback OnOpenTile;
  VoidCallback OnOpenModifica;
  VoidCallback OnOpenElimina;
  Tile(
      {super.key,
      required this.quizName,
      required this.OnOpenTile,
      required this.OnOpenModifica,
      required this.OnOpenElimina});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: OnOpenTile,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Container(
            padding: EdgeInsets.all(20),
            width: 400,
            height: 70,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(quizName),
                  PopupMenuButton(
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                          onTap: OnOpenModifica, child: Text('modifica')),
                      PopupMenuItem(
                          onTap: OnOpenElimina, child: Text('elimina'))
                    ],
                  ),
                ]),
            decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(5)),
          ),
        ));
  }
}
