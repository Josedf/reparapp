import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'firebase_signup.dart';

class FirebaseLogIn extends StatelessWidget {
  const FirebaseLogIn({Key? key}) : super(key: key);

  _login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: "c@c.com", password: "123456");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("user-not-found");
      } else if (e.code == 'wrong-password') {
        print("wrong-password");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: SignInButtonBuilder(
              backgroundColor: Colors.blueGrey,
              text: 'Sign in with Email',
              icon: Icons.email,
              onPressed: () {
                _login();
              }),
        ),
        TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FirebaseSignUp()));
            },
            child: Text("Create account"))
      ],
    );
  }
}
