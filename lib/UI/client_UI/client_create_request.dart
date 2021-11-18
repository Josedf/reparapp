import 'dart:io';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snack.dart';
import 'package:reparapp/UI/client_UI/client_images.dart';
import 'package:reparapp/UI/client_UI/client_map.dart';
import 'package:reparapp/common/Status.dart';
import 'package:reparapp/domain/controller/location_controller.dart';
import 'package:reparapp/domain/use_case/firestore_service.dart';
import 'package:image_picker/image_picker.dart';

class ClientCreateRequest extends StatefulWidget {
  const ClientCreateRequest({Key? key}) : super(key: key);

  @override
  _CreateRequestState createState() => _CreateRequestState();
}

class _CreateRequestState extends State<ClientCreateRequest> {
  TextEditingController _descriptionController = new TextEditingController();
  TextEditingController _titleController = new TextEditingController();
  bool imageSelected = false;
  final FirestoreService _firestoreService = Get.find();
  final ImagePicker _picker = ImagePicker(); //Pick image
  Image? image; //Image selected
  String img64String = ""; //Image in base64
  List<String> image64List = []; //List of images in base64

  //TextEditingController _passwordController = new TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  String dropdownValue = 'Select your category';
  final DROP_DEFAULT = 'Select your category';

  // To show Selected Item in Text.
  String holder = '';

  List<String> dropDownList = [
    'Select your category',
    'Enfriamiento',
    'Computadores',
  ];

  Future<bool> _createRequest() async {
    LocationController locationController = Get.find();
    print("Descripción: " + _descriptionController.text);
    if (_titleController.text == "" || _titleController.text.isEmpty) {
      Get.snackbar('Error', 'Please write a title for your request',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color(0xFF808080),
          colorText: Colors.white,
          borderRadius: 10,
          margin: EdgeInsets.all(10),
          snackStyle: SnackStyle.FLOATING,
          duration: Duration(seconds: 3));
      return false;
    }
    if (_descriptionController.text == "" ||
        _descriptionController.text.isEmpty) {
      Get.snackbar('Error', 'Please write a description',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color(0xFF808080),
          colorText: Colors.white,
          borderRadius: 10,
          margin: EdgeInsets.all(10),
          snackStyle: SnackStyle.FLOATING,
          duration: Duration(seconds: 3));
      return false;
    }
    if (dropdownValue == DROP_DEFAULT) {
      Get.snackbar('Error', 'Please select a category',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color(0xFF808080),
          colorText: Colors.white,
          borderRadius: 10,
          margin: EdgeInsets.all(10),
          snackStyle: SnackStyle.FLOATING,
          duration: Duration(seconds: 3));
      return false;
    }

    if (image64List.isEmpty) {
      Get.snackbar('Error', 'Please select an image',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color(0xFF808080),
          colorText: Colors.white,
          borderRadius: 10,
          margin: EdgeInsets.all(10),
          snackStyle: SnackStyle.FLOATING,
          duration: Duration(seconds: 3));
      return false;
    }

    if (locationController.userLocation.value.latitude == 0 &&
        locationController.userLocation.value.longitude == 0) {
      Get.snackbar('Error', 'Please select your location',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color(0xFF808080),
          colorText: Colors.white,
          borderRadius: 10,
          margin: EdgeInsets.all(10),
          snackStyle: SnackStyle.FLOATING,
          duration: Duration(seconds: 3));
      return false;
    }

    final _firestore = FirebaseFirestore.instance;
    String email = user!.email.toString();
    print("Selected " + dropdownValue);
    print("Description " + _descriptionController.text);
    print("Email " + email);
    Map<String, String> current_user = await _firestoreService.getClient(email);
    if (current_user == {} || current_user == null) {
      print("User not found");
      return false;
    }

    try {
      _firestore.collection("requests").add({
        "clientName": current_user["name"],
        "clientEmail": email,
        "fixerName": "",
        "fixerEmail": "",
        "phone": current_user["phone"],
        "address": current_user["address"],
        "city": current_user["city"],
        "title": _titleController.text,
        "description": _descriptionController.text,
        "category": dropdownValue,
        "img64": img64String,
        "latitude": locationController.userLocation.value.latitude.toString(),
        "longitude": locationController.userLocation.value.longitude.toString(),
        "price": "0",
        "clientAgree": "False",
        "fixerAgree": "False",
        "status": Status.CREATED.toString()
      });

      print("Request created succesfully");
      return true;
    } catch (e) {
      print("error" + e.toString());
    }
    return false;
  }

// Image Picker

//get image from gallery    //  Image Picker
  Future<void> _getImage() async {
    //final imageFile = await _picker.pickImage(source: ImageSource.gallery);
    final images = await _picker.pickMultiImage();
    if (images == null) {
      return;
    }
    img64String = "";
    setState(() {
      //Go through the images array
      for (var i = 0; i < images.length; i++) {
        File file = File(images[i].path);
        img64String += base64Encode(file.readAsBytesSync());
        if (i != images.length - 1) {
          img64String += ",";
        }
      }
      image64List = img64String.split(",");
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.topCenter,
                  child: TextButton(
                      onPressed: () {
                        Get.back();
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
              child: Text("Your request:", style: TextStyle(fontSize: 20))),
          Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Color(0xFFF6F6F6),
                    labelText: 'Your request title'),
              )),
          Padding(
              padding: EdgeInsets.all(10),
              child: Card(
                  color: Color(0xFFF6F6F6),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _descriptionController,
                      maxLines: 7,
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
                  if (imageSelected)
                    Card(
                        color: Color(0xFFA5A6F6),
                        child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ClientImages(
                                              image64List: image64List,
                                            )));
                              },
                              child: Text(
                                "See images here",
                                style: TextStyle(color: Colors.white),
                              )),
                        )),
                ],
              )),
          Padding(
              padding: EdgeInsets.all(10),
              child: MaterialButton(
                onPressed: () {
                  Get.to(() => ClientMap());
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
                  Future<bool> response = _createRequest();
                  response.then((isSuccessful) {
                    if (isSuccessful) {
                      Get.back();
                      print("Success");
                      Get.snackbar('Success', 'Request created successfully',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Color(0xFFA5A6F6),
                          colorText: Colors.white,
                          borderRadius: 10,
                          margin: EdgeInsets.all(10),
                          snackStyle: SnackStyle.FLOATING,
                          duration: Duration(seconds: 3));
                    }
                  });

                  //   Get.back(); //Primero el back , luego mostrar el snackbar.
                },
                child: Text("Send",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
                minWidth: double.maxFinite,
                color: Color(0xFF7879F1),
              )),
        ],
      ),
    ));
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
