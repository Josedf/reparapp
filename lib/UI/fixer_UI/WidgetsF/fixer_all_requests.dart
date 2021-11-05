import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reparapp/Models/Message.dart';
import 'package:reparapp/Models/Request_Model.dart';
import 'package:reparapp/UI/fixer_UI/fixer_request_state.dart';
import 'package:reparapp/UI/widgets/main_buttons.dart';
import 'package:reparapp/domain/use_case/firestore_service.dart';




class FixerAllRequests extends StatefulWidget {

  const FixerAllRequests({Key? key}) : super(key: key);

  @override
  _FixerAllRequestsState createState() => _FixerAllRequestsState();

}
  class _FixerAllRequestsState extends State<FixerAllRequests>{
    List<Request> fixers_requests=[];
    final FirestoreService _firestoreService = Get.find();
    void initState() {
      super.initState();
      User? user = FirebaseAuth.instance.currentUser;
      String? em = user!.email;
      getRequestInfo(em);
    }

    void getRequestInfo(em) async {
     Map<String,String> fixermap = await _firestoreService.getFixer(em);

      if(fixermap.isNotEmpty && fixermap != null){
        String? category = fixermap['category'];
        List<Request> fixersRequests= await _firestoreService.getRequests(category!);
        setState(() {
          fixers_requests = fixersRequests;

        });
      }
    }

    Image decoder(String img64) {
      return Image.memory(base64Decode(img64));
    }

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
                  itemCount: fixers_requests.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Request request = fixers_requests[index];

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
                                    child: decoder(request.image64List[0])
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
                                      request.name,
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
                                       request.description,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(request.time,
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.6))),
                                  ],
                                ),
                                Container(
                                    width: 40.0,
                                    height: 35.0,
                                    alignment: Alignment.bottomRight,
                                    child:  IconButton(
                                      icon: Icon(Icons.mail_outline),
                                      color: Color(0xFFA5A6F6),
                                      onPressed: () {
                                       Get.to(() => FixerRequest(address: request.address,
                                        name: request.name,
                                        time: request.time,
                                        description: request.description,
                                      title: request.title ,
                                      image64List: request.image64List ));
                                      },
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
        MainButtons(wrenchVisibility: false, isFixer: false)
      ],
    );
  }


}

