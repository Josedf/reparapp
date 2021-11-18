import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reparapp/Models/Request_Model.dart';
import 'package:reparapp/common/Status.dart';

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

  Future<String> getClientId(String email) async {
    final _firestore = FirebaseFirestore.instance;
    var sRef = _firestore.collection("users").where("email", isEqualTo: email);

    QuerySnapshot users = await sRef.get();
    if (users.docs.isNotEmpty) {
      for (var doc in users.docs) {
        return doc.id;
      }
    }
    return "user not found";
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
          "city": doc["city"],
          "clientId": doc.id
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
          "name": doc["name"],
        };
        return map;
      }
    }
    return {};
  }

  Future<List<Request>> getRequests(String category) async {
    final _firestore = FirebaseFirestore.instance;
    var sRef = _firestore
        .collection("requests")
        .where('category', isEqualTo: category);
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
          clientName: doc["clientName"],
          phone: doc["phone"],
          title: doc["title"],
          time: "13:00 pm",
          price: doc["price"],
          clientAgree: doc["clientAgree"],
          fixerAgree: doc["fixerAgree"],
          status: doc["status"],
          requestId: doc.id,
        ));
      }

      return requestList;
    }

    return [];
  }

  Future<List<Request>> getRequestsByEmail(String fixerEmail) async {
    final _firestore = FirebaseFirestore.instance;
    var sRef = _firestore
        .collection("requests")
        .where('fixerEmail', isEqualTo: fixerEmail)
        .where('fixerAgree', isEqualTo: 'False');
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
          clientName: doc["clientName"],
          phone: doc["phone"],
          title: doc["title"],
          time: "13:00 pm",
          price: doc["price"],
          clientAgree: doc["clientAgree"],
          status: doc["status"],
          fixerAgree: doc["fixerAgree"],
          requestId: doc.id,
        ));
      }

      return requestList;
    }

    return [];
  }

  Future<List<Request>> getRequestsByEmailFixerAccepted(
      String fixerEmail) async {
    final _firestore = FirebaseFirestore.instance;
    var sRef = _firestore
        .collection("requests")
        .where('fixerEmail', isEqualTo: fixerEmail)
        .where('status', isEqualTo: Status.ACCEPTED.toString());
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
            clientName: doc["clientName"],
            phone: doc["phone"],
            title: doc["title"],
            time: "13:00 pm",
            price: doc["price"],
            clientAgree: doc["clientAgree"],
            status: doc["status"],
            fixerAgree: doc["fixerAgree"],
            requestId: doc.id,
            latitude: doc["latitude"],
            longitude: doc["longitude"]));
      }

      return requestList;
    }

    return [];
  }

  Future<List<Request>> getRequestsByEmailClientAccepted(
      String clientEmail) async {
    final _firestore = FirebaseFirestore.instance;
    var sRef = _firestore
        .collection("requests")
        .where('clientEmail', isEqualTo: clientEmail)
        .where('status', isEqualTo: Status.ACCEPTED.toString());
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
            clientName: doc["clientName"],
            phone: doc["phone"],
            title: doc["title"],
            time: "13:00 pm",
            price: doc["price"],
            clientAgree: doc["clientAgree"],
            status: doc["status"],
            fixerAgree: doc["fixerAgree"],
            requestId: doc.id,
            latitude: doc["latitude"],
            longitude: doc["longitude"]));
      }

      return requestList;
    }

    return [];
  }

  Future<List<Request>> getOffers(String phone) async {
    final _firestore = FirebaseFirestore.instance;

    var sRef =
        _firestore.collection("requests").where('phone', isEqualTo: phone);
    List<Request> requestList = [];

    QuerySnapshot Requests = await sRef.get();

    if (Requests.docs.isNotEmpty) {
      //  print("Aqui");
      for (var doc in Requests.docs) {
        //print(doc["name"]);
        //print(doc["address"]);
        //print(doc["city"]);
        //print(doc["description"]);
        //print(doc["img64"].substring(0, 15));
        //print(doc["title"]);
        //print(doc["category"]);

        requestList.add(Request(
          address: doc["address"],
          category: doc["category"],
          city: doc["city"],
          description: doc["description"],
          image64List: doc["img64"].split(','),
          clientName: doc["clientName"],
          phone: doc["phone"],
          title: doc["title"],
          fixerName: doc["fixerName"],
          fixerEmail: doc["fixerEmail"],
          time: "13:00 pm",
          price: doc["price"],
          clientAgree: doc["clientAgree"],
          fixerAgree: doc["fixerAgree"],
          status: doc["status"],
          requestId: doc.id,
        ));
      }

      return requestList;
    }

    return [];
  }

  // Future<List<Request>> getRequestsLocation(String id) async {
  //   final _firestore = FirebaseFirestore.instance;
  //   var sRef = _firestore
  //       .collection("requests")
  //       .where('id', isEqualTo: id);
  //   List<Request> requestList = [];

  //   QuerySnapshot Requests = await sRef.get();
  //   if (Requests.docs.isNotEmpty) {
  //     for (var doc in Requests.docs) {
  //       requestList.add(Request(
  //           address: doc["address"],
  //           category: doc["category"],
  //           city: doc["city"],
  //           description: doc["description"],
  //           image64List: doc["img64"].split(','),
  //           name: doc["name"],
  //           phone: doc["phone"],
  //           title: doc["title"],
  //           time: "13:00 pm",
  //           id: doc["id"]));
  //     }

  //     return requestList;
  //   }

  //   return [];
  // }
}
