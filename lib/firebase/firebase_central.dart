import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reparapp/UI/client_UI/client_counter_offer.dart';
import 'package:reparapp/UI/client_UI/client_login.dart';
import 'package:reparapp/UI/client_UI/client_profile.dart';
import 'package:reparapp/UI/fixer_UI/fixer_profile.dart';
import 'package:reparapp/UI/fixer_UI/fixer_request_state.dart';
import 'package:reparapp/domain/controller/firestore_controller.dart';
import 'package:reparapp/firebase/firebase_fixer_logged.dart';
import 'package:get/get.dart';
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
        FirestoreController _firestoreController = Get.find();
        //print('users --------------------------');

        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          // GetX<FirestoreController>(
          //   builder: (controller) {
          //     if (controller.isfixer.isTrue) {
          //       return FixerProfile();
          //     } else {
          //       return ClientProfile();
          //     }
          //   },
          // );

          //_firestoreController.isFixer(user.email);

          if (_firestoreController.isfixer.isTrue) {
            //return FirebaseFixerLogged();
            printInfo(info: "fixer");
            return FixerProfile();
          } else {
            printInfo(info: "client");
            return ClientProfile();
          }

          // getUsers(user.email);
          // if (val) {
          //   return FirebaseFixerLogged();
          // } else {
          //   return ClientProfile();
          // }

        } else {
          return ClientLogIn();
          //return FirebaseLogIn();
        }

        // if (snapshot.hasData) {
        //     return FirebaseLoggedIn();
        // } else {
        //   return FirebaseLogIn();
        // }
      },
    );

    // return GetX<FirestoreController>(
    //   builder: (controller) {
    //     User? user = FirebaseAuth.instance.currentUser;
    //     if (user != null) {
    //       if (controller.isfixer.value) {
    //         return FixerProfile();
    //       } else {
    //         return ClientProfile();
    //       }
    //     } else {
    //       return ClientLogIn();
    //     }
    //   },
    // );
  }

  void getUsers(email) async {
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
