import 'package:app/util/editor_menu.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FlashcardTile extends StatelessWidget {
  final String questionText;
  final Color color;
  final VoidCallback onOpenModifica;
  final VoidCallback onOpenElimina;

  FlashcardTile({
    super.key,
    required this.color,
    required this.questionText,
    required this.onOpenModifica,
    required this.onOpenElimina,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        EditorMenu(
                context: context,
                onOpenElimina: onOpenElimina,
                onOpenModifica: onOpenModifica)
            .show();
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(30),
            color: color,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    questionText,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
