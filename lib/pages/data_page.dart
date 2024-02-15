import 'package:flutter/material.dart';

class data_page extends StatefulWidget {
  const data_page({super.key});

  @override
  State<data_page> createState() => _data_pageState();
}

class _data_pageState extends State<data_page> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'STATISTICHE',
          style: TextStyle(color: Colors.black),
        ),
        shadowColor: Colors.black,
        elevation: 10,
        centerTitle: true,
        backgroundColor: Colors.yellow,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(
            left: screenSize.width * 0.04,
            right: screenSize.width * 0.04,
            top: screenSize.height * 0.04),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: screenSize.width * 0.8,
                height: screenSize.height * 0.2,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black,
                        offset: Offset(1, 0),
                        spreadRadius: 1,
                        blurRadius: 1,
                        blurStyle: BlurStyle.normal),
                  ],
                  color: Colors.amber,
                  border: Border.all(width: 2, color: Colors.black),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: const Text(
                        'DOMANDE DELLA SETTIMANA',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline),
                      )),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Corrette : 0',
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Sbagliate : 0',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Senza risposta : 0', //aggiunta contatore risposte corrette,sbagliate e senza risposta
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
