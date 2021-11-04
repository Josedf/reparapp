import 'dart:io';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:reparapp/UI/client_UI/client_images.dart';
import 'package:reparapp/UI/client_UI/client_map.dart';
import 'package:reparapp/domain/use_case/firestore_service.dart';
import 'package:image_picker/image_picker.dart';

class ClientCreateRequest extends StatefulWidget {
  const ClientCreateRequest({Key? key}) : super(key: key);

  @override
  _CreateRequestState createState() => _CreateRequestState();
}

class _CreateRequestState extends State<ClientCreateRequest> {
  TextEditingController _descriptionController = new TextEditingController();
  bool imageSelected = false;
  final FirestoreService _firestoreService = Get.find();
  final ImagePicker _picker = ImagePicker(); //Pick image
  Image? image; //Image selected
  String img64String = ""; //Image in base64

  //TextEditingController _passwordController = new TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  String dropdownValue = 'Select your category';

  // To show Selected Item in Text.
  String holder = '';

  List<String> dropDownList = [
    'Select your category',
    'Enfriamiento',
    'Computadores',
  ];

  Future<void> _createRequest() async {
    final _firestore = FirebaseFirestore.instance;
    String email = user!.email.toString();
    print("Selected " + dropdownValue);
    print("Description " + _descriptionController.text);
    print("Email " + email);
    Map<String, String> current_user = await _firestoreService.getUser(email);

    //print(current_user["name"]);
    try {
      _firestore.collection("requests").add({
        "name": current_user["name"],
        "phone": current_user["phone"],
        "address": current_user["address"],
        "city": current_user["city"],
        "category": dropdownValue,
        "img64": img64String
      });
      print("Request created succesfully");
    } catch (e) {
      print("error" + e.toString());
    }
  }

// Image Picker

//get image from gallery    //  Image Picker
  Future<void> _getImage() async {
    //final imageFile = await _picker.pickImage(source: ImageSource.gallery);
    final imageFile2 = await _picker.pickMultiImage();
    img64String = "";

    List<int> h = [];
    setState(() {
      //Go through imageFile2
      for (var i = 0; i < imageFile2!.length; i++) {
        File file = File(imageFile2[i]!.path);
        img64String += base64Encode(file.readAsBytesSync());
        if (i != imageFile2.length - 1) {
          img64String += ",";
        }
      }
      /* final file = File(imageFile2!.path);
      // image = Image.file(File(imageFile!.path)); Guarda archivo tipo image
      final bytes = file.readAsBytesSync(); //Convertir a bytes
      img64String = base64Encode(bytes); //Encode image a base64 string*/
      // print(img64.substring(0, 100));// Imprime para ver los bytes en base64
      // final decodedBytes = base64Decode(img64); //Decode base64 string a image
      //image = Image.memory(decodedBytes);//Convertir bytes a image
      imageSelected = true;
    });
  }

  /* Future<void> _getImage() async {
    file = await _picker.pickImage(source: ImageSource.gallery);
    final path = file?.path;
    final bytes = await File(path!).readAsBytes();

    //print(image);
    setState(() {
      imageSelected = true;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    User? user = FirebaseAuth.instance.currentUser;

    // TODO: implement build
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
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
                padding: EdgeInsets.only(left: 30),
                child: Text("Create Request", style: TextStyle(fontSize: 30)),
              )
            ],
          ),
          Padding(
              padding: EdgeInsets.all(10),
              child: Card(
                  color: Color(0xFFF6F6F6),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _descriptionController,
                      maxLines: 12,
                      decoration: InputDecoration.collapsed(
                          hintText: "Post description here..."),
                    ),
                  ))),
          Padding(padding: EdgeInsets.all(15), child: dropDown()),
          Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                      color: Color(0xFFF6F6F6),
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: TextButton(
                            onPressed: () {
                              _getImage();
                            },
                            child: Text(
                              "Add your photos or videos here",
                              style: TextStyle(color: Colors.black),
                            )),
                      )),
                  Card(
                      color: Color(0xFFF6F6F6),
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ClientImages(
                                            img64: img64String,
                                          )));
                            },
                            child: Text(
                              "See images here",
                              style: TextStyle(color: Colors.black),
                            )),
                      )),
                ],
              )),
          Padding(
              padding: EdgeInsets.all(10),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ClientMap()));
                },
                child: Text("Set Location",
                    style: TextStyle(fontSize: 16, color: Color(0xFF7879F1))),
                minWidth: double.maxFinite,
                color: Color(0xFFD7E2DF),
              )),
          Padding(
              padding: EdgeInsets.all(10),
              child: MaterialButton(
                onPressed: () {
                  _createRequest();
                },
                child: Text("Send",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
                minWidth: double.maxFinite,
                color: Color(0xFF7879F1),
              )),
          Container(
              child: imageSelected ? Text("Image selected") : Text("hola")),
        ],
      ),
    ));
  }

  final List<String> imageList = [
    'assets/images/fixR1.jpg',
    'assets/images/fixR2.jpg',
  ];

  Image decoder() {
    return Image.memory(base64Decode(img64String));
  }

  Widget slideshow() {
    //Slideshow con mocks
    return Center(
      child: CarouselSlider(
        options: CarouselOptions(
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
          autoPlay: false,
        ),
        items: imageList
            .map((img64) => ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    children: <Widget>[decoder()],
                  ),
                ))
            .toList(),
      ),
    );
  }

  void getDropDownItem() {
    setState(() {
      holder = dropdownValue;
    });
  }

  Widget dropDown() {
    return Column(children: <Widget>[
      DropdownButton<String>(
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
        onChanged: ((String? data) {
          setState(() {
            dropdownValue = data!;
          });
        }),
        items: dropDownList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    ]);
  }
}
