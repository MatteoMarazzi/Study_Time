import 'dart:async';
import 'dart:ui';
import 'package:app/domain/session.dart';
import 'package:get/get.dart';

class TimerController extends GetxController {
  Timer? _timer;
  int remainingSeconds = 0; // Inizializza a 0 inizialmente
  final time = '00:00'.obs;
  int studio = 0;
  int pausa = 0;
  int ripetizioni = 0;
  late Session session;
  int timerCorrente = 0;
  int currentIteration = 0; // Contatore delle iterazioni attuali
  final VoidCallback onTimerStart;

  TimerController(this.session, this.onTimerStart);

  @override
  void onInit() {
    super.onInit();
    studio = session.minutiStudio * 1; // Converti minuti in secondi
    pausa = session.minutiPausa * 1; // Converti minuti in secondi
    ripetizioni = session.ripetizioni;
    print(ripetizioni);
    startSession();
  }

  @override
  void onClose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    resetVariables();
    super.onClose();
  }

  void resetVariables() {
    remainingSeconds = 0;
    time.value = '00:00';
    studio = 0;
    pausa = 0;
    ripetizioni = 0;
    timerCorrente = 0;
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
    if (currentIteration < (ripetizioni * 2)) {
      cambiaTimer();
      _startTimer(timerCorrente);
    } else {
      // Tutte le ripetizioni sono completate, fermare qui il timer
      print('Sessione completata');
      onTimerStart();
      onClose();
      resetVariables();
    }
  }

  void _startTimer(int seconds) {
    // Notifica l'inizio del timer
    onTimerStart();

    remainingSeconds = seconds;
    const duration = Duration(seconds: 1);
    _timer = Timer.periodic(duration, (Timer timer) {
      if (remainingSeconds < 0) {
        print("secondi rimanenti $remainingSeconds");
        timer.cancel();
        currentIteration++; // Incrementa il contatore delle iterazioni
        print("contatore : $currentIteration \nripetizioni : $ripetizioni");
        // Avvia la prossima sessione di studio o pausa solo se necessario
        if (currentIteration < ripetizioni * 2) {
          startSession();
        } else {
          print('Sessione completata');
          onTimerStart();
        }
      } else {
        int minutes = remainingSeconds ~/ 60;
        int seconds = remainingSeconds % 60;
        time.value = minutes.toString().padLeft(2, "0") +
            ":" +
            seconds.toString().padLeft(2, "0");
        remainingSeconds--; // Decrementa remainingSeconds correttamente
      }
    });
  }
}
