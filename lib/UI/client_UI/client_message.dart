import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reparapp/Models/Message.dart';
import 'package:reparapp/Models/user_model.dart';

class ClientMessage extends StatefulWidget {
  final User user;
  ClientMessage({required this.user});

  @override
  _ClientMessageState createState() => _ClientMessageState();
}



class _ClientMessageState extends State<ClientMessage> {

  _createTheMessage(Message tmessage, bool sMessage) {
    return Container(
      margin: sMessage
          ? EdgeInsets.only(top: 8.0, bottom: 8.0, left: 80.0)
          : EdgeInsets.only(top: 8.0, bottom: 8.0, right: 80.0),
      padding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 15.0),
      decoration: BoxDecoration(
        color: sMessage ? Color(0xff7879F1) : Color(0xffE8E8E8),
        borderRadius: sMessage ? BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
          bottomLeft: Radius.circular(15.0))
          : BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0)),
          ),
      child: Text(tmessage.message,
      style: TextStyle(
        color: sMessage ? Colors.white : Colors.black,
      ),
    ),);
  }

  _MessageWritingSpace(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      height: 70,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration.collapsed(
                hintText: 'Message Here...',
              ),

            ),
          ),
          IconButton(
            icon: Icon(Icons.arrow_circle_up_rounded),
            iconSize: 30.0,
            color: Color(0xFF7879F1),
            onPressed: () {},
          ),

        ],

      )

    );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Back',
                style: TextStyle(
                  fontSize: 15.0,
                  color: Color(0xFFA5A6F6),

                )),
          ),

          centerTitle: true,
          title: Text('Messages',
            style: TextStyle(color: Colors.black,
                fontSize: 30.0,
                fontWeight: FontWeight.w600),

          ),
          actions: <Widget>[

            Row(
              children: [
                Column(
                  children: [
                    IconButton(icon: Icon(Icons.person_outline),
                      iconSize: 40.0,
                      color: Colors.black,
                      onPressed: () {},),//aqui lo mandan para el perfil del fixer
                  ],
                ),
                Column(
                  children: [
                    IconButton(icon: Icon(Icons.location_on_outlined),
                      iconSize: 40.0,
                      color: Colors.black,
                      onPressed: () {},), //aqui lo mandan para el mapa
                  ],
                ),
              ],


            )
          ],
        ),


        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                    child: ListView.builder(
                        padding: EdgeInsets.only(top: 15.0),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: clientMessages.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Message tmessage = clientMessages[index];
                          bool sMessage = tmessage.sender.id == currentUser.id;
                          return _createTheMessage(tmessage, sMessage);
                        }),
                  ),

                ),
              ),
              _MessageWritingSpace(),
            ],
          ),
        )

    );
  }

}
