import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';
import 'package:reparapp/UI/client_UI/client_edit_profile.dart';
import 'package:reparapp/UI/fixer_UI/fixer_edit_profile.dart';
import 'package:reparapp/UI/fixer_UI/fixer_login.dart';
import 'package:reparapp/UI/fixer_UI/fixer_signup.dart';
import 'package:reparapp/UI/widgets/main_buttons.dart';

class FixerProfile extends StatefulWidget {
  const FixerProfile({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<FixerProfile> {
  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    String? em = user!.email;
    getUserInfo(em);
  }

  _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  String name = "";
  String email = "";
  String category = "";
  String phone = "";
  String type = "";

  void getUserInfo(em) async {
    final _firestore = FirebaseFirestore.instance;
    var sRef = _firestore
        .collection("users")
        .where("email", isEqualTo: em)
        .where("type", isEqualTo: "fixer");
    QuerySnapshot users = await sRef.get();
    if (users.docs.isNotEmpty) {
      for (var doc in users.docs) {
        print(doc);
        setState(() {
          name = doc["name"];
          email = doc["email"];
          category = doc["category"];
          phone = doc["phone"];
          type = doc["type"];
        });
        break;
      }
    } else {
      printInfo(info: "vacio");
    }
  }

  Widget widgetProfilePhoto() {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height * 0.33,
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(
          onTap: () {
            print('click on edit');
          },
          child: Image(
            image: AssetImage('assets/images/perfil.jpg'),
            fit: BoxFit.cover,
            //height: ,
            //width: ,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color(0xFF7879F1),
          title: Text("Fixer profile"),
          actions: [
            IconButton(
                onPressed: () {
                  _logout();
                },
                icon: Icon(Icons.logout))
          ],
        ),
        extendBodyBehindAppBar: false,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widgetProfilePhoto(),
              Center(
                child: Text(name,
                    style: TextStyle(fontFamily: 'Inder', fontSize: 30, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Email:",
                        style: TextStyle(
                            fontFamily: 'Inder',
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    Text(email,
                        style: TextStyle(fontFamily: 'Inder', fontSize: 20))
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Phone:",
                        style: TextStyle(
                            fontFamily: 'Inder',
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    Text(phone,
                        style: TextStyle(fontFamily: 'Inder', fontSize: 20))
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Category:",
                        style: TextStyle(
                            fontFamily: 'Inder',
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    Text(category,
                        style: TextStyle(fontFamily: 'Inder', fontSize: 20))
                  ],
                ),
              ),
              MainButtons(
                  wrenchVisibility: false, isProfile: true, isFixer: true)
            ],
          ),
        ));
  }
}
