import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reparapp/domain/use_case/firestore_service.dart';

class FirestoreController extends GetxController {
  var tipo = "".obs;
  var tipoActual = "".obs;
  var iscorrect = false.obs;
  final FirestoreService _firestoreService = Get.find();

  Future<String> isFixer(email, password, type) async {
    String rta = await _firestoreService.getUsers(email);
    //printInfo(info: "rta: $rta");
    tipo.value = rta;
    tipoActual.value = type;
    if (type == "fixer" && rta == "fixer") {
      // is on the fixer list in the database
      //printInfo(info: "1");
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        //return Future.value("correct");
      } on FirebaseAuthException catch (e) {
        return Future.value(e.code);
      }
    } else {
      if (type == "client" && rta == "client") {
        //printInfo(info: "2");
        // is NOT on the fixer list in the database
        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);
          //return Future.value("correct");
        } on FirebaseAuthException catch (e) {
          return Future.value(e.code);
        }
      } else {
        if ((type == "client" && rta == "fixer") ||
            (type == "fixer" && rta == "client")) {
          //printInfo(info: "3");
          // is the opposite type
          return Future.value("incorrect");
        } else {
          //printInfo(info: "4");
          try {
            UserCredential userCredential = await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: email, password: password);
            return Future.value("Error");
          } on FirebaseAuthException catch (e) {
            return Future.value(e.code);
          }
        }
      }
    }
    return Future.value("x");
  }
}
