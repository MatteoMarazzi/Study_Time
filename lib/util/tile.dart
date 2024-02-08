import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Tile extends StatelessWidget {
  final String quizName;
  final String quizDescription;
  Color color;
  VoidCallback OnOpenTile;
  VoidCallback OnOpenModifica;
  VoidCallback OnOpenElimina;
  Tile(
      {super.key,
      required this.quizName,
      required this.quizDescription,
      required this.color,
      required this.OnOpenTile,
      required this.OnOpenModifica,
      required this.OnOpenElimina});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 90,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: ListTile(
            onTap: OnOpenTile,
            title: Text(
              quizName,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              quizDescription,
              strutStyle: StrutStyle(
                height: 1.5,
              ),
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
            ),
            trailing: PopupMenuButton(
              color: Colors.black,
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(onTap: OnOpenModifica, child: Text('modifica')),
                PopupMenuItem(onTap: OnOpenElimina, child: Text('elimina'))
              ],
            ),
          ),
        ));
  }
}
