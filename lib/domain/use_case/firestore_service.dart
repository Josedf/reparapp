import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  Future<bool> getUsers(email) async {
    final _firestore = FirebaseFirestore.instance;
    var sRef = _firestore
        .collection("users")
        .where("email", isEqualTo: email)
        .where("type", isEqualTo: "fixer");
    QuerySnapshot users = await sRef.get();
    if (users.docs.isNotEmpty) {
      for (var doc in users.docs) {
        return true;
      }
    } else {
      return false;
    }
    return false;
  }
}
