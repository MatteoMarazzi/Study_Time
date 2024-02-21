import 'package:flutter/material.dart';
import 'dart:async';

class TomatoTimer extends StatefulWidget {
  const TomatoTimer(
      {super.key,
      required this.deadline,
      this.textStyle,
      required this.onDeadlineUpdated,
      this.labelTextStyle});
  final DateTime deadline;
  final Function(DateTime) onDeadlineUpdated;
  final TextStyle? textStyle;
  final TextStyle? labelTextStyle;
  @override
  State<TomatoTimer> createState() => _TomatoTimerState();
}

class _TomatoTimerState extends State<TomatoTimer> {
  late Timer
      timer; //per aggiornare il countdown ogni secondo (variabile per il tempo)
  Duration duration = const Duration(); //salva il tempo rimanente

  @override
  void initState() {
    calculateTimeLeft(widget.deadline);
    timer = Timer.periodic(
        const Duration(seconds: 1),
        (_) => calculateTimeLeft(
            widget.deadline)); // calcolo ogni secondo del tempo rimanente

    super.initState();
  }

  @override
  void dispose() {
    //per cancellare il timer (azzeri tempo)
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textStyle =
        widget.textStyle ?? Theme.of(context).textTheme.headlineLarge!;
    var labelTextStyle =
        widget.labelTextStyle ?? Theme.of(context).textTheme.bodyMedium!;

    final hours = DefaultTextStyle(
        style: textStyle,
        child: Text(duration.inHours.toString().padLeft(2,
            '0'))); //stampa duration; le ore; converti in stringhe; devono essere due numeri, se uno non c'è metti zero
    final minutes = DefaultTextStyle(
        style: textStyle,
        child:
            Text(duration.inMinutes.remainder(60).toString().padLeft(2, '0')));
    final seconds = DefaultTextStyle(
        style: textStyle,
        child:
            Text(duration.inSeconds.remainder(60).toString().padLeft(2, '0')));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => const LinearGradient(colors: [
                Colors.black, //colore 1 dell'effetto
                Colors.black, //colore 2 dell'effetto
              ]).createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: hours,
              ),
            ),
            DefaultTextStyle(style: labelTextStyle, child: const Text('Ore')),
          ],
        ),
        const SizedBox(
          width: 16.0,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => const LinearGradient(colors: [
                Colors.black,
                Color.fromARGB(255, 0, 0, 0),
              ]).createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: minutes,
              ),
            ),
            DefaultTextStyle(
                style: labelTextStyle, child: const Text('Minuti')),
          ],
        ),
        const SizedBox(
          width: 16.0,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => const LinearGradient(colors: [
                Colors.black,
                Color.fromARGB(255, 0, 0, 0),
              ]).createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: seconds,
              ),
            ),
            DefaultTextStyle(
                style: labelTextStyle, child: const Text('Secondi')),
          ],
        ),
      ],
    );
  }

  void calculateTimeLeft(DateTime deadline) {
    final now = DateTime.now();
    final seconds = deadline.difference(now).inSeconds;
    if (seconds >= 0) {
      setState(() {
        duration = Duration(seconds: seconds);
      });
    } else {
      // Il tempo è scaduto, chiamiamo la funzione di callback per aggiornare la scadenza
      widget.onDeadlineUpdated(now.add(const Duration(seconds: 60)));
    }
  }
}

// oppure usa atoms_box
