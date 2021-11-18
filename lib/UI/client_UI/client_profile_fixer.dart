import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';
import 'package:reparapp/UI/client_UI/client_edit_profile.dart';
import 'package:reparapp/UI/fixer_UI/fixer_login.dart';
import 'package:reparapp/UI/fixer_UI/fixer_signup.dart';
import 'client_signup.dart';

class ClientProfileFixer extends StatefulWidget {
  final bool clientToFixer;
  final String fixerEmail;

  const ClientProfileFixer({Key? key, required this.clientToFixer, required this.fixerEmail}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ClientProfileFixer> {
  @override
  void initState() {
    super.initState();
    print(widget.fixerEmail);
    getUserInfo(widget.fixerEmail);
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
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        extendBodyBehindAppBar: false,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              widgetProfilePhoto(),
              Text(""),
              Center(
                child: Text(name,
                    style: TextStyle(fontFamily: 'Inder', fontSize: 30)),
              ),
              Text(""),
              Text(""),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 5.0, bottom: 5.0, left: 20, right: 20),
                    child: Text("Email: " + email, style: TextStyle(fontFamily: 'Inder', fontSize: 24)),
                  ),
                ],
              ),
              Text(""),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 5.0, bottom: 5.0, left: 20, right: 20),
                    child: Text("Phone: " + phone, style: TextStyle(fontFamily: 'Inder', fontSize: 24)),
                  ),
                ],
              ),
              Text(""),
              Text(""),
              Padding(
                padding: EdgeInsets.only(
                    top: 10.0, bottom: 10.0, left: 20, right: 20),
                child: MaterialButton(
                  onPressed: () {},
                  child: Text("Download fixer certificate",
                      style: TextStyle(fontSize: 16, color: Color(0xFF7879F1))),
                  minWidth: double.maxFinite,
                  color: Color(0x9FFFFFFF),
                ),
              ),
              Text(""),
              
            ],
          ),
        ));
  }
}
