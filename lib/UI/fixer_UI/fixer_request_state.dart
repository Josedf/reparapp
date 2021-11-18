import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reparapp/Models/Request_Model.dart';
import 'package:reparapp/UI/fixer_UI/fixer_set_offer.dart';
import 'package:reparapp/UI/widgets/main_buttons.dart';

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

  Widget slideshow() {
    //Slideshow con mocks
    return Center(
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FixerSetOffer(
                                    requestId: widget.requestId)));
                      },
                      child: Text("Check Offer",
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
