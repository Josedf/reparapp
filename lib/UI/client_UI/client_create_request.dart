import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClientCreateRequest extends StatefulWidget {
  const ClientCreateRequest({Key? key}) : super(key: key);

  @override
  _CreateRequestState createState() => _CreateRequestState();
}

class _CreateRequestState extends State<ClientCreateRequest> {
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    String dropdownValue = 'Select your category';
    // TODO: implement build
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.only(top: statusBarHeight / 2, left: 5),
                  child: TextButton(onPressed: () {
                    Navigator.pop(context);
                  }, child: Text("Back"))),
              Padding(
                  padding: EdgeInsets.only(top: statusBarHeight / 2, left: 25),
                  child: Center(
                      child: Text("Create Request",
                          style: TextStyle(fontSize: 30))))
            ],
          ),
          Padding(
              padding: EdgeInsets.all(10),
              child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      maxLines: 8,
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
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextButton(
                        onPressed: () {},
                        child: Text("Add your photos or videos here")),
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
    );
  }
}
