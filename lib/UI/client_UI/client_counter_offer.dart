import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:reparapp/UI/widgets/main_buttons.dart';

class ClientCounterOffer extends StatefulWidget {
  const ClientCounterOffer({Key? key}) : super(key: key);

  @override
  _CounterOfferState createState() => _CounterOfferState();
}

final offerController = TextEditingController();

class _CounterOfferState extends State<ClientCounterOffer> {
  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    String dropdownValue = 'Select your category';
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 15),
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
                  padding: EdgeInsets.only(left: 100),
                  child: Text("Offer",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, top: 20),
            child: Text("Make Counter Offer",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: EdgeInsets.only(top: 70, left: 15, right: 15),
            child: TextFormField(
              controller: offerController,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Color(0xFFF6F6F6),
                  labelText: 'Offer'),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 300),
            child: ElevatedButton(
              onPressed: () {
                //_login();
              },
              child: Text("Set Offer",
                  style: TextStyle(fontSize: 16, color: Colors.white)),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF7879F1),
                padding:
                    const EdgeInsets.symmetric(horizontal: 140, vertical: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 17.5),
              child: MainButtons(
                wrenchVisibility: false,
              ))
        ],
      ),
    ));
  }
}
