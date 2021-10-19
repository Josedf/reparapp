import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reparapp/UI/client_UI/client_create_request.dart';
import 'package:reparapp/UI/client_UI/client_login.dart';
import 'package:reparapp/firebase/firebase_fixer_logged.dart';


import 'firebase_client_logged.dart';
import 'firebase_login.dart';

class FirebaseCentral extends StatefulWidget {
  const FirebaseCentral({Key? key}) : super(key: key);

  @override
  State<FirebaseCentral> createState() => _FirebaseCentralState();
}

class _FirebaseCentralState extends State<FirebaseCentral> {
  @override
  bool val = false;
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        //print('users --------------------------');

        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          getUsers(user.email);
          if (val) {
            return FirebaseFixerLogged();
          } else {
            return FirebaseLoggedIn();
          }
          // bool val;
          // getUsers(user.uid).then((value) {
          //   val = value;
          //   if (value) {
          //     print(value);
          //     return FirebaseLoggedIn();
          //   } else {
          //     return FirebaseLogIn();
          //   }
          // });
        } else {
          return ClientCreateRequest();
          //return FirebaseLogIn();
        }

        // if (snapshot.hasData) {
        //     return FirebaseLoggedIn();
        // } else {
        //   return FirebaseLogIn();
        // }
      },
    );
  }

  void getUsers(email) async {
    // CollectionReference collectionReference =
    //     FirebaseFirestore.instance.collection("users");

    // QuerySnapshot users = await collectionReference.get();
    // if (users.docs.isNotEmpty) {
    //   for (var doc in users.docs) {
    //     print(doc.data());
    //   }
    // }
    final _firestore = FirebaseFirestore.instance;
    var sRef = _firestore
        .collection("users")
        .where("email", isEqualTo: email)
        .where("type", isEqualTo: "fixer");
    QuerySnapshot users = await sRef.get();
    if (users.docs.isNotEmpty) {
      for (var doc in users.docs) {
        setState(() {
          val = true;
        });
        break;
      }
    } else {
      setState(() {
        val = false;
      });
    }
  }
}
