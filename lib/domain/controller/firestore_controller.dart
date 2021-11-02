import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reparapp/domain/use_case/firestore_service.dart';

class FirestoreController extends GetxController {
  var isfixer = false.obs;
  var iscorrect = false.obs;
  final FirestoreService _firestoreService = Get.find();

  Future<bool> isFixer(email, password, type) async {
    bool rta = await _firestoreService.getUsers(email);
    printInfo(info: "rta: $rta");
    isfixer.value = rta;

    if (type == "fixer" && rta == true) {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return Future.value(true);
    }

    if (type == "client" && rta == false) {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return Future.value(true);
    }

    return Future.value(false);
  }
}
