import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reparapp/Models/Request_Model.dart';

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

  Future<Map<String, String>> getClient(String email) async {
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

  Future<Map<String, String>> getFixer(String email) async {
    final _firestore = FirebaseFirestore.instance;
    var sRef = _firestore.collection("users").where("email", isEqualTo: email);

    Map<String, String> map = {};
    QuerySnapshot users = await sRef.get();
    if (users.docs.isNotEmpty) {

      for (var doc in users.docs) {

        map = {
          "category": doc["category"],
          "email": doc["email"],
          "type": doc["type"],
        };
        return map;
      }
    }
    return {};
  }



  Future<List<Request>> getRequests(String category) async {
    final _firestore = FirebaseFirestore.instance;
    var sRef = _firestore.collection("requests").where('category', isEqualTo: category);
     List<Request> requestList = [];


    QuerySnapshot Requests = await sRef.get();
    if (Requests.docs.isNotEmpty) {
      for (var doc in Requests.docs) {

        requestList.add(Request(
           address: doc["address"],
           category: doc["category"],
           city: doc["city"],
            description: doc["description"],
            image64List: doc["img64"].split(','),
            name: doc["name"],
            phone: doc["phone"],
            title: doc["title"],
            time: "13:00 pm"
        ));



      }

      return requestList;
    }

    return [];
  }

}
