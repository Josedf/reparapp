import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'WidgetsC/ClientHistory.dart';
import 'WidgetsC/client_ all_offers.dart';
import 'WidgetsC/client_all_chats.dart';




class ClientChatsView extends StatefulWidget {
  @override
  _ClientChatsViewState createState() => _ClientChatsViewState();
}

class _ClientChatsViewState extends State<ClientChatsView> {
  int groupValue = 0;

  final Map<int, Widget> ChatsWidgets = <int, Widget>{
    0:buildSegments('Offers'),

    1: buildSegments('History'),
  };

  static Widget buildSegments(String text) => Container(
        padding: EdgeInsets.all(10),
        child: Text(text, style: TextStyle(fontSize: 15)),
      );



  List<Widget> bodies = [
    ClientAllOffers(),
    ClientHistory(),

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
