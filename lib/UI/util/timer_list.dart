import 'package:flutter/material.dart';

class TimerTile extends StatefulWidget {
  const TimerTile({
    super.key,
    required this.timerS,
    required this.timerP,
    required this.pOrS,
  });
  final int timerP;
  final int timerS;
  final int pOrS;
  @override
  State<TimerTile> createState() => _TimerTileState();
}

class _TimerTileState extends State<TimerTile> {
  late List<Color> colorList = [];
  late List<String> titleList = [];
  int counter = 0;
  late List<String> timerList = [];
  @override
  void initState() {
    titleList.add('PAUSA');
    titleList.add('STUDIO');
    timerList.add(widget.timerP.toString());
    timerList.add(widget.timerS.toString());
    colorList.add(const Color.fromARGB(103, 76, 175, 79));
    colorList.add(const Color.fromARGB(104, 132, 213, 251));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.arrow_circle_down,
          size: 60,
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: 200,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(20),
            color: colorList[widget.pOrS],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  left: 8,
                  right: 8,
                ),
                child: Text(
                  titleList[widget.pOrS],
                  style: const TextStyle(
                    fontFamily: 'Garamond',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 7.0), //ci devi aggiungere il child
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      timerList[widget.pOrS],
                      style: const TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      ' minuti',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
