import 'package:flutter/material.dart';

// ignore: must_be_immutable
class QuestionTile extends StatelessWidget {
  String question;
  String answer;
  VoidCallback OnOpenTile;
  VoidCallback OnOpenModifica;
  VoidCallback OnOpenElimina;
  QuestionTile(
      {super.key,
      required this.question,
      required this.answer,
      required this.OnOpenTile,
      required this.OnOpenModifica,
      required this.OnOpenElimina});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
          height: 90,
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: ListTile(
              onTap: OnOpenTile,
              title: Row(
                //attualmente inutilizzata, ma si vorrebbe aggiungere il numero di domande per quiz
                children: [
                  Text(
                    question,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              subtitle: Text(
                answer,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: PopupMenuButton(
                icon: Icon(
                  Icons.more_vert_rounded,
                  color: Colors.black,
                ),
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(onTap: OnOpenModifica, child: Text('modifica')),
                  PopupMenuItem(onTap: OnOpenElimina, child: Text('elimina'))
                ],
              ),
            ),
          )),
    );
  }
}
