import 'package:flutter/material.dart';
import 'package:one_clock/one_clock.dart';

class analogClock extends StatelessWidget {
  const analogClock({super.key});

  @override
  Widget build(BuildContext context) {
    return AnalogClock(
      decoration: BoxDecoration(
          border: Border.all(width: 2.0, color: Colors.black),
          color: Colors.transparent,
          shape: BoxShape.circle),
      width: 150.0,
      isLive: true,
      hourHandColor: Colors.transparent,
      minuteHandColor: Colors.black,
      showSecondHand: true,
      numberColor: Colors.black87,
      showNumbers: false,
      showAllNumbers: false,
      textScaleFactor: 1.4,
      showTicks: false,
      showDigitalClock: false,
      datetime: DateTime(2024, 8, 6, 0, 0, 0),
    );
  }
}
