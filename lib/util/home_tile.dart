import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math'; //serve per poter fare standard^2

class Home_tile extends StatelessWidget {
  final Color color;
  final Color backgroundColor; // Aggiungiamo il colore di sfondo
  final Widget destinationPage; // Correggo il tipo del parametro
  final String boxTitle;
  final String pathImage;
  final double heightImage;
  final double weightImage;
  final double standard;

  const Home_tile({
    Key? key,
    required this.color,
    required this.backgroundColor, // Aggiorniamo il costruttore
    required this.destinationPage, // Aggiorniamo il costruttore con il widget destinazione
    required this.boxTitle,
    required this.pathImage,
    required this.heightImage,
    required this.weightImage,
    required this.standard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

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
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.04),
            child: Row(
              children: [
                Container(
                  width:
                      screenSize.width * (0.92 / standard), // Bordo larghezza
                  height: 100 * (standard), // Bordo altezza
                  decoration: BoxDecoration(
                    color: backgroundColor, // Utilizziamo il colore di sfondo
                    border: Border.all(color: Colors.black, width: 3.0),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Stack(children: [
                    Center(
                        child: Container(
                      height: 31.0 * pow(standard, 2.2),
                      child: Text(
                        boxTitle, //titolo assegnato da noi come parametro
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    )),
                    Positioned(
                        right: //Se metti left (sta a sinistra della scritta) e viceversa
                            190.0 -
                                pow(standard,
                                    7.83), //Serve per posizionare immagine (destra/sinistra)
                        bottom: -19.0 +
                            pow(standard,
                                4.25), //Serve per posizionare immagine(su/giù)
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
              ],
            )));
  }
}
