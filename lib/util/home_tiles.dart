import 'package:flutter/material.dart';

class HomeTile extends StatelessWidget {
  final Color
      color; //ANCORA NON IMPLEMENTATO, HO MESSO DI DEFAUL IL NERO.Sarebbe colore scritte
  final Color backgroundColor; // Aggiungiamo il colore di sfondo
  final Widget destinationPage; // Correggo il tipo del parametro
  final String boxTitle;

  const HomeTile({
    Key? key,
    required this.color,
    required this.backgroundColor, // Aggiorniamo il costruttore
    required this.destinationPage, // Aggiorniamo il costruttore con il widget destinazione
    required this.boxTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    destinationPage), // Utilizziamo il widget destinazione per la navigazione
          );
        },
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    width: 325, // Bordo esterno larghezza
                    height: 80, // Bordo esterno altezza
                    decoration: BoxDecoration(
                      color: backgroundColor, // Utilizziamo il colore di sfondo
                      border: Border.all(color: Colors.black, width: 3.0),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Container(
                        width: 310, // Bordo interno larghezza
                        height: 30, // Bordo interno altezza
                        child: Center(
                          child: Text(
                            boxTitle,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }
}





/*Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/allarm_clock.png'),
              )
          ),
        ),*/