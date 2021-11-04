import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // Future<bool> getUsers(email) async {
  //   final _firestore = FirebaseFirestore.instance;
  //   var sRef = _firestore
  //       .collection("users")
  //       .where("email", isEqualTo: email)
  //       .where("type", isEqualTo: "fixer");
  //   QuerySnapshot users = await sRef.get();
  //   if (users.docs.isNotEmpty) {
  //     for (var doc in users.docs) {
  //       return true;
  //     }
  //   } else {
  //     return false;
  //   }
  //   return false;
  // }

  Future<String> getUsers(email) async {
    final _firestore = FirebaseFirestore.instance;
    var sRef = _firestore
        .collection("users")
        .where("email", isEqualTo: email)
        .where("type", isEqualTo: "fixer");
    QuerySnapshot users = await sRef.get();
    if (users.docs.isNotEmpty) {
      for (var doc in users.docs) {
        return "fixer";
      }
    } else {
      sRef = _firestore
          .collection("users")
          .where("email", isEqualTo: email)
          .where("type", isEqualTo: "client");
      users = await sRef.get();
      if (users.docs.isNotEmpty) {
        for (var doc in users.docs) {
          return "client";
        }
      }
    }
    return "x";
  }

  Future<Map<String, String>> getUser(String email) async {
    final _firestore = FirebaseFirestore.instance;
    var sRef = _firestore.collection("users").where("email", isEqualTo: email);

    Map<String, String> map = {};
    QuerySnapshot users = await sRef.get();
    if (users.docs.isNotEmpty) {
      for (var doc in users.docs) {
        map = {
          "address": doc["address"],
          "name": doc["name"],
          "phone": doc["phone"],
          "type": doc["type"],
          "city": doc["city"]
        };
        return map;
      }
    }

    return {};
  }
}
