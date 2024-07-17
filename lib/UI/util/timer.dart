import 'dart:async';

import 'package:app/domain/session.dart';
import 'package:get/get.dart';

class TimerController extends GetxController {
  Timer? _timer;
  int remainingSeconds = 1;
  final time = '00:00'.obs;
  int studio = 0;
  int pausa = 0;
  int ripetizioni = 0;
  late Session session;
  int timerCorrente = 0;
  int currentIteration = 0; // Contatore delle iterazioni attuali

  TimerController(this.session);

  @override
  void onInit() {
    super.onInit();
    studio = session.minutiStudio * 1;
    pausa = session.minutiPausa * 1;
    ripetizioni = session.ripetizioni;
    timerCorrente = studio;
    currentIteration = 0;
    startSession();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.onClose();
    currentIteration = 0;
  }

  void cambiaTimer() {
    if (currentIteration % 2 == 0) {
      timerCorrente = studio;
    } else {
      timerCorrente = pausa;
    }
  }

  void startSession() {
    // Controlla se ci sono ancora ripetizioni da fare
    if (currentIteration < ripetizioni) {
      _startTimer(timerCorrente);
      cambiaTimer();
    } else {
      // Tutte le ripetizioni sono completate, puoi fare qualche azione o fermare tutto
      print('Sessione completata');
    }
  }

  void _startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainingSeconds = seconds;
    _timer = Timer.periodic(duration, (Timer timer) {
      if (remainingSeconds == 0) {
        timer.cancel();
        currentIteration++; // Incrementa il contatore delle iterazioni
        // Avvia la prossima sessione dopo la pausa, se ci sono ancora ripetizioni
        if (currentIteration < ripetizioni) {
          timerCorrente = pausa;
          time.value = '00:00'; // Resetta il timer visualizzato
          startSession(); // Avvia la pausa o la prossima sessione di studio
        }
      } else {
        int minutes = remainingSeconds ~/ 60;
        int seconds = remainingSeconds % 60;
        time.value = minutes.toString().padLeft(2, "0") +
            ":" +
            seconds.toString().padLeft(2, "0");
        remainingSeconds--;
      }
    });
  }
}
