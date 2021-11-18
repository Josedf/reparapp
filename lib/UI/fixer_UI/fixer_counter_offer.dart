import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:reparapp/UI/widgets/main_buttons.dart';

class FixerCounterOffer extends StatefulWidget {
  final String address;
  final String name;
  final String time;
  final String title;
  final List<String> image64List; //Image in base64;
  final String requestId;
  final String price;

  const FixerCounterOffer(
      {Key? key,
      required this.address,
      required this.name,
      required this.time,
      required this.title,
      required this.image64List,
      required this.requestId,
      required this.price})
      : super(key: key);

  @override
  _CounterOfferState createState() => _CounterOfferState();
}

final offerController = TextEditingController();

class _CounterOfferState extends State<FixerCounterOffer> {
  int current_index = 0;

  Image decoder(String img64) {
    return Image.memory(base64Decode(img64));
  }

  Widget slideshow() {
    //Slideshow con mocks
    return Center(
        child: Container(
            decoration: new BoxDecoration(color: Colors.white),
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
                items: widget.image64List
                    .map((img64) => ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Stack(
                            children: <Widget>[decoder(img64)],
                          ),
                        ))
                    .toList(),
              ),
            )));
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
                    child: Text("Price: \$" + widget.price,
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                Padding(
                    padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Accept offer",
                          style: TextStyle(fontSize: 19, color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF7879F1),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Decline offer",
                          style: TextStyle(fontSize: 19, color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF7879F1),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
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
