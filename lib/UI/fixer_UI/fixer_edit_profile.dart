import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reparapp/UI/fixer_UI/fixer_login.dart';
import 'package:reparapp/UI/fixer_UI/fixer_signup.dart';

class FixerEditProfile extends StatefulWidget {
  const FixerEditProfile({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<FixerEditProfile> {
  String name = "";
  String email = "";
  String address = "";
  String phone = "";
  String city = "";
  String type = "";

  @override
  void initState() {
    super.initState();
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

  Widget mainButtons() {
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
                      onPressed: () {},
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
                    onPressed: () {},
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

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  String dropdownValue = 'Select your new Category';

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
                    'Select your new Category',
                    'Computadores',
                    'Enfriamiento',
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
                  controller: nameController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Color(0xFFF6F6F6),
                      labelText: 'Write your new Phone'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: MaterialButton(
                  onPressed: () {},
                  child: Text("Upload new certificate",
                      style: TextStyle(fontSize: 16)),
                  minWidth: double.maxFinite,
                  color: Color(0x9FFFFFFF),
                ),
              ),
              mainButtons(),
            ],
          ),
        ));
  }
}
