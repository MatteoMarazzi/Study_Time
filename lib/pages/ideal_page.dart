import 'package:flutter/material.dart';

class IdealPage extends StatelessWidget {
  const IdealPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
          child: Padding(
              padding: EdgeInsets.only(
                  left: screenSize.width * 0.04,
                  right: screenSize.width * 0.04,
                  top: screenSize.height * 0.06),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      "PERCHE' CREARE SESSIONI DI STUDIO REGOLARI",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 35),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 18.0, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                            text:
                                'Stabilire un programma di studio regolare aiuta a creare una routine e a rendere lo studio una parte integrante della giornata. Questo può portare a diversi '),
                        TextSpan(
                            text: 'vantaggi',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: ':\n\n\n'),
                        TextSpan(
                            text: 'Costanza e disciplina: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                'Studiare a orari prestabiliti riduce la procrastinazione. Ad esempio, se decidi di studiare ogni giorno dalle 16:00 alle 18:00, il tuo cervello si abitua a questo orario e sarà più facile iniziare e mantenere la concentrazione.\n\n'),
                        TextSpan(
                            text: 'Migliore gestione del tempo: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                'Creare un calendario di studio aiuta a suddividere il carico di lavoro. Supponiamo che tu abbia un esame importante tra un mese. Pianificare sessioni di studio quotidiane permette di affrontare l\'intero programma in modo graduale, evitando di dover fare tutto all\'ultimo momento.\n\n'),
                        TextSpan(
                            text: 'Riduzione dello stress: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                'Avere un piano chiaro e definito riduce l\'ansia legata allo studio. Sapere esattamente quando e quanto studiare ti permette di dedicare tempo anche ad altre attività senza sensi di colpa. Ad esempio, se sai che hai già studiato due ore al mattino, potrai dedicare il pomeriggio a un\'attività rilassante senza preoccupazioni.\n\n'),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      "COS'E IL METODO DEL POMODORO",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 35),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 18.0, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(text: 'Il '),
                        TextSpan(
                            text: 'metodo del pomodoro',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                ' è una tecnica di gestione del tempo che consiste nell\'alternare periodi di lavoro concentrato a brevi pause. Questo metodo è particolarmente utile per mantenere '),
                        TextSpan(
                            text: 'alta la concentrazione e la produttività',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                '. Vediamo come funziona e i suoi benefici:\n\n'),
                        TextSpan(
                            text: 'Sessioni di lavoro brevi e intense',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                ': Il metodo prevede di lavorare per 25 minuti (un "pomodoro") seguiti da una pausa di 5 minuti. Dopo quattro pomodori, si prende una pausa più lunga di 15-30 minuti. Questo approccio rende il lavoro meno opprimente e più gestibile. Ad esempio, puoi studiare la biologia per 25 minuti, fare una pausa di 5 minuti, e poi passare a un\'altra materia o continuare con la biologia.\n\n'),
                        TextSpan(
                            text: 'Aumento della concentrazione',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                ': Sapere che devi lavorare solo per 25 minuti ti aiuta a mantenere alta la concentrazione. Durante questo periodo, evita distrazioni e focalizzati sul compito da svolgere. Ad esempio, puoi mettere il telefono in modalità aereo o usarlo solo per tenere traccia del tempo.\n\n'),
                        TextSpan(
                            text: 'Pianificazione delle pause',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                ': Le pause regolari aiutano a evitare l\'affaticamento mentale. Durante i 5 minuti di pausa, puoi fare stretching, bere un bicchiere d\'acqua o fare una breve passeggiata. Queste attività aiutano a ricaricare le energie e a mantenere alta la produttività durante tutta la sessione di studio.'),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  Text(
                    "Esempio pratico ",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 18.0, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                            text:
                                'Immagina di dover preparare un esame di matematica. Decidi di studiare ogni giorno dalle 15:00 alle 17:00. Dividi queste due ore in quattro sessioni da 25 minuti usando il metodo del pomodoro:\n\n\n'),
                        TextSpan(
                            text: '15:00-15:25: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: 'Studio dei teoremi di geometria\n'),
                        TextSpan(
                            text: '15:25-15:30: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: 'Pausa (stretching)\n'),
                        TextSpan(
                            text: '15:30-15:55: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: 'Esercizi sui teoremi studiati\n'),
                        TextSpan(
                            text: '15:55-16:00: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: 'Pausa (Bicchiere d\'acqua)\n'),
                        TextSpan(
                            text: '16:00-16:25: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: 'Studio delle funzioni\n'),
                        TextSpan(
                            text: '16:25-16:30: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: 'Pausa (breve passeggiata)\n'),
                        TextSpan(
                            text: '16:30-16:55: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: 'Esercizi sulle funzioni\n'),
                        TextSpan(
                            text: '16:55-17:00: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: 'Pausa (rilassamento)\n\n\n'),
                        TextSpan(
                            text:
                                'In questo modo, hai suddiviso lo studio in segmenti gestibili, mantenendo alta la concentrazione e riducendo lo stress. Inoltre, le pause regolari ti aiutano a rimanere fresco e motivato per tutta la durata della sessione.\n\nIn '),
                        TextSpan(
                            text: 'conclusione, ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                'creare sessioni di studio regolari e utilizzare il metodo del pomodoro sono strategie efficaci per migliorare l\'efficacia dello studio, mantenere la concentrazione e ridurre lo stress. Integrando queste tecniche nella tua routine, potrai affrontare il tuo percorso di apprendimento in modo più strutturato e produttivo.'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  )
                ],
              ))),
    ));
  }
}
