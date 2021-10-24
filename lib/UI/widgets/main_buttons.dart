import 'package:flutter/material.dart';
import 'package:reparapp/UI/client_UI/client_counter_offer.dart';
import 'package:reparapp/UI/client_UI/client_create_request.dart';
import 'package:reparapp/UI/client_UI/client_edit_profile.dart';

class MainButtons extends StatelessWidget {
  bool wrenchVisibility;
  MainButtons({this.wrenchVisibility = true}); //Constructor

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        Container(
            height: 95,
            alignment: AlignmentDirectional.bottomStart,
            child: Container(
              height: 60,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Icon(Icons.chat, size: 40),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF7879F1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                      ),
                    ),
                  ),
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ClientEditProfile()));
                    },
                    child: Icon(Icons.edit, size: 40),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF7879F1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                    ),
                  )),
                ],
              ),
            )),
        Visibility(
          child: Container(
            alignment: Alignment.center,
            child: Container(
                height: 80,
                width: 80,
                child: FittedBox(
                    child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ClientCounterOffer()));
                  },
                  backgroundColor: Color(0xFFA5A6F6),
                  child: Icon(Icons.build, color: Colors.white, size: 40),
                ))),
          ),
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          visible: wrenchVisibility,
        ),
      ],
    );
  }
}
