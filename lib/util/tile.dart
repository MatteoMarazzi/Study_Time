import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class Tile extends StatelessWidget {
  final String quizName;
  final String quizDescription;
  VoidCallback OnOpenTile;
  VoidCallback OnOpenModifica;
  VoidCallback OnOpenElimina;
  Tile(
      {super.key,
      required this.quizName,
      required this.quizDescription,
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
            height: 80,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        quizName,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        quizDescription,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w200),
                      )
                    ],
                  ),
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
