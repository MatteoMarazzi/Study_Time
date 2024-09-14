import 'package:flutter/material.dart';

// ignore: must_be_immutable
class QuestionTile extends StatelessWidget {
  String questionText;
  VoidCallback onOpenModifica;
  VoidCallback onOpenElimina;
  QuestionTile(
      {super.key,
      required this.questionText,
      required this.onOpenModifica,
      required this.onOpenElimina});

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
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      questionText,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
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
