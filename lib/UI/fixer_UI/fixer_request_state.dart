import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reparapp/Models/Request_Model.dart';
import 'package:reparapp/UI/fixer_UI/fixer_set_offer.dart';
import 'package:reparapp/UI/widgets/main_buttons.dart';
import 'package:reparapp/common/Status.dart';
import 'package:reparapp/domain/use_case/firestore_service.dart';

class FixerRequest extends StatefulWidget {
  final String address;
  final String name;
  final String time;
  final String description;
  final String title;
  final List<String> image64List; //Image in base64;
  final String requestId;

  const FixerRequest(
      {Key? key,
      required this.address,
      required this.name,
      required this.time,
      required this.description,
      required this.title,
      required this.image64List,
      required this.requestId})
      : super(key: key);

  @override
  FixerRequestState createState() => FixerRequestState();
}

class FixerRequestState extends State<FixerRequest> {
  int current_index = 0;
  final FirestoreService _firestoreService = Get.find();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
  }

  final List<String> imageList = [
    'assets/images/fixR1.jpg',
    'assets/images/fixR2.jpg',
  ];

  Image decoder(String img64) {
    return Image.memory(base64Decode(img64));
  }

  void _updateStatus(
      Status status, String fixerAgree, String clientAgree) async {
    final _firestore = FirebaseFirestore.instance;
    
    String email = user!.email.toString();
    DocumentReference documentReferencer =
        _firestore.collection("requests").doc(widget.requestId);
    print(status);
    Map<String, String> fixer = await _firestoreService.getFixer(email);
    await documentReferencer.update({
      "fixerName": fixer["name"],
      "fixerEmail": email,
      "fixerAgree": fixerAgree,
      "clientAgree": clientAgree,
      "status": status.toString()
    });
  }

  Widget slideshow() {
    //Slideshow con mocks
    return Center(
        child: Container(
          decoration: new BoxDecoration(
            color: Colors.white
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: CarouselSlider(
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                current_index = index;
                print("Image#: " + current_index.toString());
              },
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              autoPlay: false,
            ),
            items: widget.image64List
                .map((img64) => ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Stack(
                        children: <Widget>[decoder(img64)],
                      ),
                    ))
                .toList(),
          ),)
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 0),
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
                  padding: EdgeInsets.only(left: 75),
                  child: Text("Request",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
          slideshow(),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(widget.title,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold))),
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text("Autor: " + widget.name,
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold))),
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text("Dirección: " + widget.address,
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold))),
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(widget.description,
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF666666)))),
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        print(widget.requestId);
                        _updateStatus(Status.ACCEPTED,"True","True");
                        Get.back();
                      },
                      child: Text("Accept Offer",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF7879F1),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 140, vertical: 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                      ),
                    )),
                //0xFF666666
              ],
            ),
          ),
          MainButtons(
            wrenchVisibility: false,
          )
        ],
      ),
    )));
  }
}
