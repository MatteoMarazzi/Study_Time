import 'package:app/pages/login_page.dart';
import 'package:app/pages/main_page.dart';
import 'package:app/util/noti_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SignUpPage(),
      );
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isSignUpButtonEnabled = false;
  final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  void initState() {
    super.initState();
    nameController.addListener(_validateInputs);
    emailController.addListener(_validateInputs);
    passwordController.addListener(_validateInputs);

    _validateInputs();
  }

  void _validateInputs() {
    if (mounted) {
      setState(() {
        isSignUpButtonEnabled = nameController.text.isNotEmpty &&
            passwordController.text.length > 6 &&
            emailRegex.hasMatch(emailController.text.trim());
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());

      final firestore = FirebaseFirestore.instance;

      final sessionsSnapshot = await firestore.collection('sessions').get();
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "name": nameController.text,
        "email": emailController.text,
        "createdAt": FieldValue.serverTimestamp(),
        "completedSessions": 0,
        "studyTime": 0,
      });

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
      if (e.code == 'email-already-in-use') {
        errorMessage = "Questa email è già in uso.";
      } else if (e.code == 'invalid-email') {
        errorMessage = "Formato email non valido.";
      } else if (e.code == 'weak-password') {
        errorMessage = "La password è troppo debole.";
      } else if (e.code == 'operation-not-allowed') {
        errorMessage = "Operazione non permessa.";
      }

      print("Errore di registrazione: ${e.code}");
      print(e.message);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } catch (e) {
      print("Errore generico: $e");
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
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Nome',
                ),
              ),
              const SizedBox(height: 15),
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
                onPressed: isSignUpButtonEnabled
                    ? () async {
                        await createUserWithEmailAndPassword();
                      }
                    : null,
                child: const Text(
                  'ISCRIVITI',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade300,
                  disabledBackgroundColor: Colors.grey,
                  foregroundColor: Colors.black,
                  disabledForegroundColor: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, LoginPage.route());
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Hai già un account? ',
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: 'Accedi',
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
