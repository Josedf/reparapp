import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class ClientCreateRequest extends StatefulWidget {
  const ClientCreateRequest({Key? key}) : super(key: key);

  @override
  _CreateRequestState createState() => _CreateRequestState();
}

class _CreateRequestState extends State<ClientCreateRequest> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    String dropdownValue = 'Select your category';
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
                      child: Text("Back", style: TextStyle(color: Color(0xFFA5A6F6))))),
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
                      maxLines: 12,
                      decoration: InputDecoration.collapsed(
                          hintText: "Post description here..."),
                    ),
                  ))),
          Padding(
            padding: EdgeInsets.all(15),
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
              items: <String>['Select your category', 'Two', 'Free', 'Four']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(10),
              child: Card(
                  color: Color(0xFFF6F6F6),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextButton(
                        onPressed: () {},
                        child: Text("Add your photos or videos here", style: TextStyle(color: Colors.black),)),
                  ))),
          Padding(
              padding: EdgeInsets.all(10),
              child: MaterialButton(
                onPressed: () {},
                child: Text("Set Location",
                    style: TextStyle(fontSize: 16, color: Color(0xFF7879F1))),
                minWidth: double.maxFinite,
                color: Color(0xFFD7E2DF),
              )),
          Padding(
              padding: EdgeInsets.all(10),
              child: MaterialButton(
                onPressed: () {},
                child: Text("Send",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
                minWidth: double.maxFinite,
                color: Color(0xFF7879F1),
              ))
        ],
      ),
    ));
  }
}
