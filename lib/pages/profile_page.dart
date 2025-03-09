import 'package:app/util/common_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  late Future<Map<String, dynamic>> userDataFuture;

  @override
  void initState() {
    super.initState();
    userDataFuture = getUserStats();
  }

  Future<Map<String, dynamic>> getUserStats() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null)
      return await {
        'name': 'Utente',
        'createdAt': 'Data non disponibile',
        'email': 'Nessuna email',
        'flashcardStats': {}
      };

    // Recupera dati utente
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    String userName = doc.exists && doc.data() != null && doc['name'] != null
        ? doc['name']
        : 'Utente';

    // Recupera data creazione account
    String accountCreationDate = 'Data non disponibile';
    if (doc.exists && doc['createdAt'] != null) {
      DateTime date = (doc['createdAt'] as Timestamp).toDate();
      accountCreationDate = "${date.day}/${date.month}/${date.year}";
    }
    String email = doc.exists && doc.data() != null && doc['email'] != null
        ? doc['email']
        : 'Nessuna email';

    // Recupera i quiz creati dall'utente
    QuerySnapshot quizSnapshot = await FirebaseFirestore.instance
        .collection('quizzes')
        .where('creator', isEqualTo: user.uid)
        .get();

    int easyCount = 0, difficultCount = 0, newCount = 0;

    for (var quiz in quizSnapshot.docs) {
      QuerySnapshot flashcardSnapshot =
          await quiz.reference.collection('flashcards').get();

      for (var flashcard in flashcardSnapshot.docs) {
        int difficulty = flashcard['difficulty'] ?? 0;
        if (difficulty == difficultyToInt(Difficulty.nonValutata)) {
          newCount++;
        } else if (difficulty == difficultyToInt(Difficulty.facile)) {
          easyCount++;
        } else if (difficulty == difficultyToInt(Difficulty.difficile)) {
          difficultCount++;
        }
      }
    }

    return {
      'name': userName,
      'createdAt': accountCreationDate,
      'email': email,
      'flashcardStats': {
        'facili': easyCount,
        'difficili': difficultCount,
        'nonValutate': newCount
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(217, 255, 255, 255),
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
            future: userDataFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Text("Errore nel caricamento");
              }
              String userName = snapshot.data!['name']!;
              String accountCreationDate = snapshot.data!['createdAt']!;
              String email = snapshot.data!['email']!;
              Map<String, int> flashcardStats =
                  snapshot.data!['flashcardStats'];

              return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
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
                    child: Padding(
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
                            flashcardStats['difficili']! > 0
                                ? 'Facili/Difficili: ${(flashcardStats['facili']! / flashcardStats['difficili']!).toStringAsFixed(2)}'
                                : (flashcardStats['facili']! > 0
                                    ? 'Facili/Difficili: Solo Facili'
                                    : 'Facili/Difficili: N/A'),
                            style: const TextStyle(fontSize: 15),
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
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: Text(
                            'STATISTICHE GENERALI FLASHCARDS',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline),
                          )),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Facili : ${flashcardStats['facili']}',
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Difficili : ${flashcardStats['difficili']}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Non valutate : ${flashcardStats['nonValutate']}',
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 125,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        ListTile(
                          leading: const Icon(
                            Icons.email_outlined,
                            color: Colors.black,
                          ),
                          title: const Text(
                            'Email',
                            style: TextStyle(fontSize: 20),
                          ),
                          subtitle: Text('$email'),
                          onTap: null, //da implementare modifica email
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ListTile(
                          leading:
                              const Icon(Icons.logout, color: Colors.black),
                          title: const Text(
                            'Esci',
                            style: TextStyle(fontSize: 20),
                          ),
                          onTap: () async {
                            await FirebaseAuth.instance.signOut();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
