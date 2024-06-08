import 'package:app/UI/util/clock.dart';
import 'package:flutter/material.dart';

class sessionPage extends StatelessWidget {
  const sessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: analogClock(),
      ),
    );
  }
}
