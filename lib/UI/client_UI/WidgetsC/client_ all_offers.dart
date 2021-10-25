import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reparapp/Models/Message.dart';
import 'package:reparapp/UI/widgets/main_buttons.dart';

class ClientAllOffers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: ListView.builder(
                  itemCount: clientChats.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Message userChat = clientChats[index];
                    return Container(
                      child: Container(
                        margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                        decoration: BoxDecoration(
                          color: Color(0x2FA5A6F6),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  //or 15.0

                                  child: Container(
                                    height: 130.0,
                                    width: 382.0,
                                    color: Colors.white,
                                    child: Image.asset(userChat.sender.ppic,
                                        width: 357, height: 130),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      userChat.sender.name,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 5.0),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.60,
                                      child: Text(
                                        userChat.message,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(userChat.time,
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.6))),
                                  ],
                                ),
                                Container(
                                    width: 40.0,
                                    height: 35.0,
                                    alignment: Alignment.bottomRight,
                                    child: Icon(
                                      Icons.keyboard_arrow_up_rounded,
                                      color: Color(0xFFA5A6F6),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ),
        MainButtons()
      ],
    );
  }
}
