import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:reparapp/UI/client_UI/WidgetsC/client_%20all_offers.dart';
import 'package:reparapp/UI/client_UI/client_chats_view.dart';
import 'package:reparapp/UI/widgets/main_buttons.dart';
import 'package:reparapp/domain/use_case/firestore_service.dart';

class ClientCounterOffer extends StatefulWidget {
  final String requestId;
  const ClientCounterOffer({Key? key, required this.requestId})
      : super(key: key);

  @override
  _CounterOfferState createState() => _CounterOfferState();
}

final offerController = TextEditingController();

class _CounterOfferState extends State<ClientCounterOffer> {
  final FirestoreService _firestoreService = Get.find();

  void _setOffer(String price) async {
    final _firestore = FirebaseFirestore.instance;

    DocumentReference documentReferencer =
        _firestore.collection("requests").doc(widget.requestId);

    await documentReferencer.update({
      "price": price,
      "fixerAgree":"False",
      "clientAgree":"True"
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Back",
                            style: TextStyle(color: Color(0xFFA5A6F6))))),
                Padding(
                  padding: EdgeInsets.only(left: 100),
                  child: Text("Offer",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, top: 20),
            child: Text("Make Counter Offer",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: EdgeInsets.only(top: 70, left: 15, right: 15),
            child: TextFormField(
              controller: offerController,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Color(0xFFF6F6F6),
                  labelText: 'Offer'),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 300),
            child: ElevatedButton(
              onPressed: () {
                _setOffer(offerController.text);
                Get.to(() => ClientChatsView());
              },
              child: Text("Set Offer",
                  style: TextStyle(fontSize: 16, color: Colors.white)),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF7879F1),
                padding:
                    const EdgeInsets.symmetric(horizontal: 140, vertical: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
              ),
            ),
          ),
          MainButtons(
            wrenchVisibility: false,
          )
        ],
      ),
    ));
  }
}
