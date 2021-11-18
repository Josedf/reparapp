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
import 'package:reparapp/UI/client_UI/client_map.dart';
import 'package:reparapp/domain/use_case/firestore_service.dart';
import 'package:image_picker/image_picker.dart';

class ClientImages extends StatelessWidget {
  int current_index = 0;
  bool imageSelected = false;
  final ImagePicker _picker = ImagePicker(); //Pick image
  Image? image; //Image selected
  List<String> image64List; //Image in base64
  ClientImages({this.image64List = const []});

// Image Picker

//get image from gallery    //  Image Picker

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
        mainAxisAlignment: MainAxisAlignment.start,
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
                padding: EdgeInsets.only(left: 80),
                child: Text("Images", style: TextStyle(fontSize: 30)),
              )
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 150), child: slideshow()),
        ],
      ),
    ));
  }

  Image decoder(String img64) {
    return Image.memory(base64Decode(img64));
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
            items: image64List
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

  /*final List<String> imageList = [
    'assets/images/fixR1.jpg',
    'assets/images/fixR2.jpg',
  ];

  Widget slideshow() {
    //Slideshow con mocks
    print(img64);
    return Center(
      child: CarouselSlider(
        options: CarouselOptions(
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
          autoPlay: false,
        ),
        items: imageList
            .map((image) => ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image(
                        image: AssetImage(image),
                        fit: BoxFit.cover,
                        width: 1050,
                        height: 350,
                      )
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }*/
}
