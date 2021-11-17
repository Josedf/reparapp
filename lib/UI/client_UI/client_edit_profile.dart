import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reparapp/UI/fixer_UI/fixer_login.dart';
import 'package:reparapp/UI/fixer_UI/fixer_signup.dart';
import 'client_signup.dart';

class ClientEditProfile extends StatefulWidget {
  const ClientEditProfile({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ClientEditProfile> {
  @override
  void initState() {
    super.initState();
  }

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  String dropdownValue = 'Select your new City';

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

  Future<bool> _updateProfile(BuildContext context) async {
    if (nameController.text == "" || nameController.text.isEmpty) {
      Get.snackbar('Error', 'Please write a name',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color(0xFF808080),
          colorText: Colors.white,
          borderRadius: 10,
          margin: EdgeInsets.all(10),
          snackStyle: SnackStyle.FLOATING,
          duration: Duration(seconds: 3));
      return false;
    }

    if (dropdownValue == "Select your new City") {
      Get.snackbar('Error', 'Please select a city',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color(0xFF808080),
          colorText: Colors.white,
          borderRadius: 10,
          margin: EdgeInsets.all(10),
          snackStyle: SnackStyle.FLOATING,
          duration: Duration(seconds: 3));
      return false;
    }

    if (phoneController.text == "" || phoneController.text.isEmpty) {
      Get.snackbar('Error', 'Please write a phone number',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color(0xFF808080),
          colorText: Colors.white,
          borderRadius: 10,
          margin: EdgeInsets.all(10),
          snackStyle: SnackStyle.FLOATING,
          duration: Duration(seconds: 3));
      return false;
    }

    if (addressController.text == "" || addressController.text.isEmpty) {
      Get.snackbar('Error', 'Please write an address',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color(0xFF808080),
          colorText: Colors.white,
          borderRadius: 10,
          margin: EdgeInsets.all(10),
          snackStyle: SnackStyle.FLOATING,
          duration: Duration(seconds: 3));
      return false;
    }

    try {
      final _firestore = FirebaseFirestore.instance;

      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String em = user.email!;
        getClientId(em).then((value) async {
          if (value != "user not found") {
            DocumentReference documentReferencer =
                _firestore.collection("users").doc(value);
            await documentReferencer.update({
              "type": "client",
              "name": nameController.text,
              "phone": phoneController.text,
              "address": addressController.text,
              "city": dropdownValue,
            });
            Get.snackbar('Success', 'Your info has been updated',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Color(0xFFA5A6F6),
                colorText: Colors.white,
                borderRadius: 10,
                margin: EdgeInsets.all(10),
                snackStyle: SnackStyle.FLOATING,
                duration: Duration(seconds: 3));
            return true;
          } else {
            Get.snackbar('Error', 'User not found',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Color(0xFF808080),
                colorText: Colors.white,
                borderRadius: 10,
                margin: EdgeInsets.all(10),
                snackStyle: SnackStyle.FLOATING,
                duration: Duration(seconds: 3));
            return false;
          }
        });
        return false;
      } else {
        printError(info: "user null");
        return false;
      }
    } on FirebaseAuthException catch (e) {
      printError(info: e.code);
      return false;
    }
  }

  Widget widgetProfilePhoto() {
    double height = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width * 0.8,
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

  Widget mainButtons(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: 95,
            alignment: AlignmentDirectional.bottomStart,
            child: Container(
              height: 60,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text("Cancel"),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF7879F1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                      ),
                    ),
                  ),
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {
                      _updateProfile(context);
                      //Get.back();
                    },
                    child: Text("Accept"),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF7879F1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                    ),
                  )),
                ],
              ),
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color(0xFF7879F1),
          title: Text("Edit your profile here"),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text("Click on the photo to change it",
                    style: TextStyle(fontFamily: 'Inder', fontSize: 20)),
              ),
              widgetProfilePhoto(),
              Text(""),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Color(0xFFF6F6F6),
                      labelText: 'Write your new Name'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: <String>[
                    'Select your new City',
                    'Barranquilla',
                    'Bogotá',
                    'Cali',
                    'Medellín',
                    'Cartagena'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Color(0xFFF6F6F6),
                      labelText: 'Write your new Phone'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Color(0xFFF6F6F6),
                      labelText: 'Write your new Address'),
                ),
              ),
              mainButtons(context),
            ],
          ),
        ));
  }
}
