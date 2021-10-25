import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reparapp/UI/client_UI/client_edit_profile.dart';
import 'package:reparapp/UI/fixer_UI/fixer_login.dart';
import 'package:reparapp/UI/fixer_UI/fixer_signup.dart';
import 'client_signup.dart';

class ClientProfileFixer extends StatefulWidget {
  const ClientProfileFixer({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ClientProfileFixer> {
  @override
  void initState() {
    super.initState();
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
                child: Text("Fixer Name",
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
                    child: Text("Email: " + "fixer@gmail.com"),
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
                    child: Text("Phone: " + "3012222222"),
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
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Volver",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF7879F1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
            ],
          ),
        ));
  }
}
