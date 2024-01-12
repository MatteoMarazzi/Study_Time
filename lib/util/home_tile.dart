import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Home_tile extends StatelessWidget {
  final Color color;
  final Color backgroundColor; // Aggiungiamo il colore di sfondo
  final Widget destinationPage; // Correggo il tipo del parametro
  final String boxTitle;
  final String pathImage;
  final double heightImage;
  final double weightImage;

  const Home_tile({
    Key? key,
    required this.color,
    required this.backgroundColor, // Aggiorniamo il costruttore
    required this.destinationPage, // Aggiorniamo il costruttore con il widget destinazione
    required this.boxTitle,
    required this.pathImage,
    required this.heightImage,
    required this.weightImage,
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
                    width: 500, // Bordo esterno larghezza
                    height: 100, // Bordo esterno altezza
                    decoration: BoxDecoration(
                      color: backgroundColor, // Utilizziamo il colore di sfondo
                      border: Border.all(color: Colors.black, width: 3.0),
                      borderRadius: BorderRadius.circular(15),
                    ),

                    child: Stack(children: [
                      Center(
                        child: Container(
                          width: 500, // Bordo interno larghezza
                          height: 150, //Bordo interno larghezza
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: BorderRadius.circular(15),
                          ), // Bordo interno altezza
                        ),
                      ),
                      Center(
                        child: Text(
                          boxTitle, //titolo assegnato da noi come parametro
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Positioned(
                          right: //Se metti left (sta a sinistra della scritta) e viceversa
                              190, //Serve per posizionare immagine (destra/sinistra)
                          bottom: -20, //Serve per posizionare immagine(su/giù)
                          child: Container(
                              width:
                                  weightImage, //Serve per modificare larghezza immagine
                              height:
                                  heightImage, //Serve per modificare altezza immagine
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(pathImage),
                                    fit: BoxFit.contain),
                              )))
                    ]),
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