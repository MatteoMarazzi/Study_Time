import 'package:app/util/dialogue_box.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});
  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  List domande = [];

  final _controller = TextEditingController();

  void salvaDomanda() async{
    setState(() {
      domande.add(_controller.text);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }
  
  void createQuestion() async{
    showDialog(
      context: context,
      builder: (context){
        return DialogueBox(
          controller: _controller,
          OnSalva: salvaDomanda,
          OnAnnulla: () => Navigator.of(context).pop(),
        );
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createQuestion,
        child: const Icon(Icons.add),
      ),
    );
  }
}
