import 'package:app/pages/main_page.dart';
import 'package:app/pages/sign_up_page.dart';
import 'package:app/util/noti_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const LoginPage(),
      );
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isSignInButtonEnabled = false;
  final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  void initState() {
    super.initState();
    emailController.addListener(_validateInputs);
    passwordController.addListener(_validateInputs);

    _validateInputs();
  }

  void _validateInputs() {
    if (mounted) {
      setState(() {
        isSignInButtonEnabled = passwordController.text.length > 6 &&
            emailRegex.hasMatch(emailController.text.trim());
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> loginUserWithEmailAndPassword() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      final firestore = FirebaseFirestore.instance;

      final sessionsSnapshot = await firestore
          .collection('sessions')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('sessions')
          .get();

      if (sessionsSnapshot.docs.isEmpty) {
        await firestore
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('sessions')
            .doc('standard')
            .set({
          'creator': FirebaseAuth.instance.currentUser!.uid,
          'title': 'STANDARD',
          'minutiStudio': 25,
          'minutiPausa': 4,
          'ripetizioni': 4,
          'ultimoAvvio': Timestamp.fromDate(DateTime.now()),
        });

        await firestore
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('sessions')
            .doc('personalizzata1')
            .set({
          'creator': FirebaseAuth.instance.currentUser!.uid,
          'title': 'PERSONALIZZATA 1',
          'minutiStudio': 0,
          'minutiPausa': 0,
          'ripetizioni': 0,
          'ultimoAvvio': Timestamp.fromDate(DateTime.now()),
        });

        await firestore
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('sessions')
            .doc('personalizzata2')
            .set({
          'creator': FirebaseAuth.instance.currentUser!.uid,
          'title': 'PERSONALIZZATA 2',
          'minutiStudio': 0,
          'minutiPausa': 0,
          'ripetizioni': 0,
          'ultimoAvvio': Timestamp.fromDate(DateTime.now()),
        });
      }
      if (mounted) {
        NotiService().sendRandomDailyNotification();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MainPage(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Si è verificato un errore. Riprova.";
      if (e.code == 'user-not-found') {
        errorMessage = "Nessun utente trovato con questa email.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Password errata. Riprova.";
      } else if (e.code == 'invalid-email') {
        errorMessage = "Formato email non valido.";
      } else if (e.code == 'user-disabled') {
        errorMessage = "Questo account è stato disabilitato.";
      } else if (e.code == 'invalid-credential') {
        errorMessage = "Credenziali errate o scadute.";
      }

      print("Errore di autenticazione: ${e.code}");
      print(e.message);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } catch (e) {
      print('Errore generico: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Errore imprevisto. Riprova.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Study Time',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  hintText: 'Password (+7 caratteri)',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isSignInButtonEnabled
                    ? () async {
                        await loginUserWithEmailAndPassword();
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade300,
                  disabledBackgroundColor: Colors.grey,
                  foregroundColor: Colors.black,
                  disabledForegroundColor: Colors.black,
                ),
                child: const Text(
                  'ACCEDI',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, SignUpPage.route());
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Non hai un account? ',
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: 'Iscriviti',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
