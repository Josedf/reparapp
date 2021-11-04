import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class DropDown extends StatefulWidget {
  @override
  DropDownWidget createState() => DropDownWidget();
  String getDropDownItem() {
    return DropDownWidget().holder;
  }
}

class DropDownWidget extends State<DropDown> {
  // Default Drop Down Item.
  String dropdownValue = 'Tom Cruise';

  // To show Selected Item in Text.
  String holder = '';

  List<String> actorsName = [
    'Robert Downey, Jr.',
    'Tom Cruise',
    'Leonardo DiCaprio',
    'Will Smith',
    'Tom Hanks'
  ];

  void getDropDownItem() {
    setState(() {
      holder = dropdownValue;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        items: actorsName.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    ]);
  }
}
