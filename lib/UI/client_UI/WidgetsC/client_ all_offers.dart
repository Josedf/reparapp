import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:reparapp/Models/Message.dart';
import 'package:reparapp/Models/Offer_Model.dart';
import 'package:reparapp/Models/Request_Model.dart';
import 'package:reparapp/UI/client_UI/client_fix_offer.dart';
import 'package:reparapp/UI/widgets/main_buttons.dart';
import 'package:reparapp/common/Status.dart';
import 'package:reparapp/domain/use_case/firestore_service.dart';

class ClientAllOffers extends StatefulWidget {
  const ClientAllOffers({Key? key}) : super(key: key);

  @override
  _ClientAllOffersState createState() => _ClientAllOffersState();
}

class _ClientAllOffersState extends State<ClientAllOffers> {
  List<Request> clients_offers = [];
  final FirestoreService _firestoreService = Get.find();
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    String? em = user!.email;
    getOfferInfo(em);
  }

  void getOfferInfo(em) async {
    Map<String, String> clientmap = await _firestoreService.getClient(em);

    if (clientmap.isNotEmpty && clientmap != null) {
      String? cliente = clientmap['phone'];

      List<Request> clientOffers = await _firestoreService.getOffers(cliente!);
      clientOffers.removeWhere((element) => !element.fixerAgrees()  || (element.clientAgrees() && element.fixerAgrees()) || (element.getStatus() == Status.DECLINED) );

      setState(() {
        clients_offers = clientOffers;
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
                  itemCount: clients_offers.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Request offer = clients_offers[index];

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
                                      icon: Icon(Icons.arrow_forward_ios),
                                      color: Color(0xFFA5A6F6),
                                      onPressed: () {
                                        Get.to(() => ClientFixOffer(
                                              title: offer.title,
                                              image64List: offer.image64List,
                                              price: offer.price,
                                              fixerEmail: offer.fixerEmail,
                                              fixerName: offer.fixerName,
                                              request: offer,
                                            ));
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
        MainButtons()
      ],
    );
  }
}
