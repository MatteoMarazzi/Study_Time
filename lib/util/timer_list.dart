import 'package:app/objects/timer.dart';
import 'package:flutter/material.dart';

class timer_Tile extends StatefulWidget {
  const timer_Tile({
    super.key,
    required this.timer_s,
    required this.timer_p,
    required this.p_or_s,
  });
  final int timer_p;
  final int timer_s;
  final int p_or_s;
  @override
  State<timer_Tile> createState() => _timer_TileState();
}

class _timer_TileState extends State<timer_Tile> {
  late List<Color> colorList = [];
  late List<String> titleList = [];
  int counter = 0;
  late List<String> timerList = [];
  @override
  void initState() {
    titleList.add('PAUSA');
    titleList.add('STUDIO');
    timerList.add(widget.timer_p.toString());
    timerList.add(widget.timer_s.toString());
    colorList.add(Color.fromARGB(103, 76, 175, 79));
    colorList.add(Color.fromARGB(104, 132, 213, 251));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.arrow_circle_down,
          size: 60,
        ),
        SizedBox(
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
            color: colorList[widget.p_or_s],
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
                  titleList[widget.p_or_s],
                  style: TextStyle(
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
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      timerList[widget.p_or_s],
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
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
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
