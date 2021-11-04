import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  }

  _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      print(e);
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
                child: Text("Fixer Name",
                    style: TextStyle(fontFamily: 'Inder', fontSize: 30)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 5.0, bottom: 5.0, left: 20, right: 20),
                    child: Text("Email: " + "fixer@gmail.com",
                        style: TextStyle(fontFamily: 'Inder', fontSize: 18)),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 5.0, bottom: 5.0, left: 20, right: 20),
                    child: Text("Phone: " + "3012222222",
                        style: TextStyle(fontFamily: 'Inder', fontSize: 18)),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 5.0, bottom: 5.0, left: 20, right: 20),
                    child: Text("category: " + "Computadores",
                        style: TextStyle(fontFamily: 'Inder', fontSize: 18)),
                  ),
                ],
              ),
              MainButtons(
                  wrenchVisibility: false, isProfile: true, isFixer: true)
            ],
          ),
        ));
  }
}
