import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseSignUpFixer extends StatelessWidget {
  const FirebaseSignUpFixer({Key? key}) : super(key: key);

  Future<void> _signup(BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: "c2@c.com", password: "123456");

      final _firestore = FirebaseFirestore.instance;
      _firestore.collection("users").add({
        "email": "c2@c.com",
        "type": "fixer",
      });

      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: TextButton(
              onPressed: () {
                _signup(context);
              },
              child: Text("Sign up fixer"))),
    );
  }
}
