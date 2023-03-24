// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_final_fields

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:institute_management_app/screens/main_page.dart';
import 'package:logger/logger.dart';
// import 'package:flutter/screens/item.dart';
import '../reusable_widgets/reusable_widgets.dart';
import 'ResetPassword.dart';
import 'Signup.dart';

final logger = Logger(
  level: Level.debug,
  printer: PrettyPrinter(),
);

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();

  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromRGBO(18, 194, 233, 1),
          Color.fromRGBO(196, 113, 237, 1),
          Color.fromRGBO(246, 79, 89, 1)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SafeArea(
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  children: <Widget>[
                    // LogoWidget('images/logo.jpg'), // add custom image here to run
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
                      'Welcome Back',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(color: const Color(0xfffff8e8)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Login to your account',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: const Color(0xfffff8e8)),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    reusableTextField("Email Address", Icons.mail_outline,
                        false, _emailTextController),
                    SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Password", Icons.lock_outline, true,
                        _passwordTextController),
                    SizedBox(
                      height: 4,
                    ),
                    forgetPassword(context),
                    firebaseUIButton(context, "Log In", () {
                      final form = formKey.currentState!;

                      if (form.validate()) {
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: _emailTextController.text,
                                password: _passwordTextController.text)
                            .then((value) {
                          logger.i("Logged in");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainPage()));
                        }).onError((error, stackTrace) {
                          logger.e("Error: $error");
                        });
                      }
                    }),
                    signUpOption(),
                  ],
                ),
              ),
            ),
          ),
        ),
        // child: Text("ssss"),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Forgot your password ?",
          style: TextStyle(color: Colors.white70),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignUp()));
          },
          child: const Text(
            " Sign up",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        )
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Forgot Password ?",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.right,
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ResetPassword()));
        },
      ),
    );
  }
}
