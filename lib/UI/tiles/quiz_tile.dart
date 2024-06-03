import 'package:flutter/material.dart';

// ignore: must_be_immutable
class QuizTile extends StatelessWidget {
  final String quizName;
  final String quizDescription;
  Color color;
  VoidCallback onOpenTile;
  VoidCallback onOpenModifica;
  VoidCallback onOpenElimina;
  QuizTile(
      {super.key,
      required this.quizName,
      required this.quizDescription,
      required this.color,
      required this.onOpenTile,
      required this.onOpenModifica,
      required this.onOpenElimina});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
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
              onTap: onOpenTile,
              title: Row(
                //attualmente inutilizzata, ma si vorrebbe aggiungere il numero di domande per quiz
                children: [
                  Text(
                    quizName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              subtitle: Text(
                quizDescription,
                strutStyle: const StrutStyle(
                  height: 1.5,
                ),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
              ),
              trailing: PopupMenuButton(
                icon: const Icon(
                  Icons.more_vert_rounded,
                  color: Colors.black,
                ),
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                      onTap: onOpenModifica, child: const Text('modifica')),
                  PopupMenuItem(
                      onTap: onOpenElimina, child: const Text('elimina'))
                ],
              ),
            ),
          )),
    );
  }
}
