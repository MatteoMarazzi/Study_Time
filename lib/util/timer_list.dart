import 'package:app/objects/timer.dart';
import 'package:flutter/material.dart';

class timer_Tile extends StatefulWidget {
  const timer_Tile({super.key, required this.timer, required this.p_or_s});
  final int timer;
  final int p_or_s;
  @override
  State<timer_Tile> createState() => _timer_TileState();
}

class _timer_TileState extends State<timer_Tile> {
  late List<String> titleList = [];
  int counter = 0;
  late String timerS = widget.timer.toString();

  @override
  void initState() {
    titleList.add('STUDIO');
    titleList.add('PAUSA');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 20,
        ),
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
            color: Color.fromARGB(104, 132, 213, 251),
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
                      timerS,
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
      ],
    );
  }
}
