import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reparapp/UI/client_UI/Widgets/all_offers.dart';

import 'Widgets/all_chats.dart';

class ChatsView extends StatefulWidget {
  @override
  _ChatsViewState createState() => _ChatsViewState();
}

class _ChatsViewState extends State<ChatsView> {
  int groupValue = 0;

  final Map<int, Widget> ChatsWidgets = <int, Widget>{
    0: buildSegments('Chats'),
    1: buildSegments('Offers'),
  };

  static Widget buildSegments(String text) => Container(
        padding: EdgeInsets.all(10),
        child: Text(text, style: TextStyle(fontSize: 15)),
      );



  List<Widget> bodies = [
    AllChats(),
    AllOffers(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodies[groupValue],
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: Padding(
            padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: CupertinoSegmentedControl(
                  padding: EdgeInsets.all(28),
                  borderColor: Color(0xFFA5A6F6),
                  selectedColor: Color(0xFFA5A6F6),
                  pressedColor: Color(0xFFE8E9FC),
                  groupValue: groupValue,
                  onValueChanged: (int changeGroupValue) {
                    setState(() {
                      groupValue = changeGroupValue;
                    });
                  },
                  children: ChatsWidgets,
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
