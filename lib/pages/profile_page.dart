import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  Future<Map<String, String>> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (doc.exists && doc.data() != null) {
        var data = doc.data() as Map<String, dynamic>;
        String userName = data.containsKey('name') ? data['name'] : 'Utente';

        // Recupero e formatto la data di creazione
        String accountCreationDate = 'Data non disponibile';
        if (data.containsKey('createdAt')) {
          Timestamp timestamp = data['createdAt'];
          DateTime date = timestamp.toDate();
          accountCreationDate = "${date.day}/${date.month}/${date.year}";
        }

        return {
          'name': userName,
          'createdAt': accountCreationDate,
        };
      }
    }
    return {'name': 'Utente', 'createdAt': 'Data non disponibile'};
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(217, 255, 255, 255),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(
            left: screenSize.width * 0.04,
            right: screenSize.width * 0.04,
            top: screenSize.height * 0.04),
        child: Center(
          child: FutureBuilder<Map<String, String>>(
              future: getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text("Errore nel caricamento");
                }
                String userName = snapshot.data!['name']!;
                String accountCreationDate = snapshot.data!['createdAt']!;
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 130,
                          width: 130,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/default-avatar.avif'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ciao ${userName} 👋',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  //decoration: TextDecoration.underline,
                                  decorationThickness: 1),
                            ),
                            Text(
                              'Account creato il ${accountCreationDate}',
                              style: TextStyle(
                                  fontSize: 12,
                                  //decoration: TextDecoration.underline,
                                  decorationThickness: 1),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: screenSize.width * 0.8,
                      height: screenSize.height * 0.11,
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black,
                              offset: Offset(1, 0),
                              spreadRadius: 1,
                              blurRadius: 1,
                              blurStyle: BlurStyle.normal),
                        ],
                        color: const Color.fromARGB(255, 230, 233, 235),
                        border: Border.all(width: 2, color: Colors.black),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                                child: Text(
                              'RATEO',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline),
                            )),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Corrette/Sbagliate : 1,2',
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
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
                        color: const Color.fromARGB(255, 230, 233, 235),
                        border: Border.all(width: 2, color: Colors.black),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                                child: Text(
                              'STATISTICHE GENERALI',
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
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Card(
                      elevation: 5,
                      color: Colors.white,
                      shadowColor: Colors.black,
                      margin: const EdgeInsets.all(0),
                      child: TextButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                        },
                        style: ButtonStyle(
                          animationDuration: const Duration(seconds: 5),
                          overlayColor: MaterialStateProperty.all(Colors.grey),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Log out',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
