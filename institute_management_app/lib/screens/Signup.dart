// ignore_for_file: prefer_const_constructors, avoid_print, prefer_interpolation_to_compose_strings

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../reusable_widgets/reusable_widgets.dart';
import 'Login.dart';

final logger = Logger(
  level: Level.debug,
  printer: PrettyPrinter(),
);

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _usernameTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _usernameTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromRGBO(18, 194, 233, 1),
          Color.fromRGBO(196, 113, 237, 1),
          Color.fromRGBO(246, 79, 89, 1)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 100),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 60,
                  ),
                  const Icon(
                    Icons.lock,
                    size: 100,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Register',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: const Color(0xfffff8e8)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Create your account',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: const Color(0xfffff8e8)),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  reusableTextField("Email Address", Icons.mail_outline, false,
                      _emailTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Password", Icons.lock_outline, true,
                      _passwordTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  firebaseUIButton(context, "Sign Up", () {
                    final form = formKey.currentState!;

                    if (form.validate()) {
                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: _emailTextController.text,
                              password: _passwordTextController.text)
                          .then((value) {
                        logger.i("Account created");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      }).onError((error, stackTrace) {
                        logger.e("Error: $error");
                      });
                    }
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
