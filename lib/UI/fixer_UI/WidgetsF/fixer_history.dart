import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';
import 'package:reparapp/Models/Message.dart';
import 'package:reparapp/Models/Offer_Model.dart';
import 'package:reparapp/Models/Request_Model.dart';
import 'package:reparapp/UI/fixer_UI/fixer_map.dart';
import 'package:reparapp/UI/widgets/main_buttons.dart';
import 'package:reparapp/common/Status.dart';
import 'package:reparapp/domain/controller/location_controller.dart';
import 'package:reparapp/domain/use_case/firestore_service.dart';

class FixerHistory extends StatefulWidget {
  const FixerHistory({Key? key}) : super(key: key);

  @override
  _FixerHistoryState createState() => _FixerHistoryState();
}

class _FixerHistoryState extends State<FixerHistory> {
  List<Request> fixers_requests = [];
  final FirestoreService _firestoreService = Get.find();
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    String? em = user!.email;
    getHistoryInfo(em);
  }

  void getHistoryInfo(em) async {
    Map<String, String> fixermap = await _firestoreService.getFixer(em);
    
    if (fixermap.isNotEmpty && fixermap != null) {
      String? category = fixermap['category'];
      List<Request> fixersRequests =
          await _firestoreService.getRequests(category!);
      List<Request> fixersCounterRequests =
          await _firestoreService.getRequestsByEmailFixerAccepted(em);
          print(fixersCounterRequests);
      setState(() {
        for (Request request in fixersCounterRequests) {
          //if (request.fixerEmail == em && request.getStatus() == Status.ACCEPTED) {
          fixers_requests.add(request);
          
          //}
        }

        //fixers_requests.addAll(fixersCounterRequests);
      });
    }
  }

  Image decoder(String img64) {
    return Image.memory(base64Decode(img64));
  }

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
                    final Request offer = fixers_requests[index];

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
                                    child: decoder(offer.image64List[0]),
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
                                      offer.title,
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
                                        offer.description,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(offer.time,
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.6))),
                                  ],
                                ),
                                Container(
                                    width: 40.0,
                                    height: 35.0,
                                    alignment: Alignment.bottomRight,
                                    child: IconButton(
                                      icon: Icon(Icons.update),
                                      color: Color(0xFFA5A6F6),
                                      onPressed: () {
                                        LocationController locationController =
                                            Get.find();
                                        // var lat = num.tryParse(offer.lat)?.toDouble();
                                        // var lon = num.tryParse(offer.lon)?.toDouble();

                                        String subLat =
                                            offer.latitude.substring(0, 5);
                                        String subLon =
                                            offer.longitude.substring(0, 5);
                                        double lat = double.parse(subLat);
                                        double lon = double.parse(subLon);
                                        Get.to(() => FixerMap(
                                            latitud: lat, longitud: lon));
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
        MainButtons(wrenchVisibility: false, isFixer: true)
      ],
    );
  }
}
