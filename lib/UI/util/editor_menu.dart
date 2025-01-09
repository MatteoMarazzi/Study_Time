import 'package:flutter/material.dart';

class EditorMenu {
  final BuildContext context;
  VoidCallback onOpenModifica;
  VoidCallback onOpenElimina;

  EditorMenu(
      {required this.context,
      required this.onOpenElimina,
      required this.onOpenModifica});

  void show() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
        builder: (BuildContext context) {
          return Container(
            height: 170,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(2)),
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: const Icon(
                    Icons.edit,
                    color: Colors.black,
                  ),
                  title: const Text(
                    'Modifica',
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: onOpenModifica,
                ),
                ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: const Text(
                    'Elimina',
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: onOpenElimina,
                ),
              ],
            ),
          );
        });
  }
}
