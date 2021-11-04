import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reparapp/UI/client_UI/client_chats_view.dart';
import 'package:reparapp/UI/client_UI/client_chats_view.dart';
import 'package:reparapp/UI/client_UI/client_counter_offer.dart';
import 'package:reparapp/UI/client_UI/client_create_request.dart';
import 'package:reparapp/UI/client_UI/client_edit_profile.dart';
import 'package:reparapp/UI/client_UI/client_profile.dart';
import 'package:reparapp/UI/fixer_UI/fixer_chats_view.dart';
import 'package:reparapp/UI/fixer_UI/fixer_chats_view.dart';
import 'package:reparapp/UI/fixer_UI/fixer_counter_offer.dart';
import 'package:reparapp/UI/fixer_UI/fixer_edit_profile.dart';
import 'package:reparapp/UI/fixer_UI/fixer_profile.dart';
import 'package:reparapp/UI/fixer_UI/fixer_set_offer.dart';
import 'package:reparapp/firebase/firebase_central.dart';

class MainButtons extends StatelessWidget {
  bool wrenchVisibility;
  bool isProfile;
  bool isFixer;
  MainButtons(
      {this.wrenchVisibility = true,
      this.isProfile = false,
      this.isFixer = false}); //Constructor

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
                      onPressed: () {
                        Get.to(() =>
                            isFixer ? FixerChatsView() : ClientChatsView());
                      },
                      child: Icon(Icons.chat, size: 40),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF7879F1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                      ),
                    ),
                  ),
                  Expanded(
                      child: isProfile
                          ? ElevatedButton(
                              onPressed: () {
                                Get.to(() => isFixer
                                    ? FixerEditProfile()
                                    : ClientEditProfile());
                              },
                              child: Icon(Icons.edit, size: 40),
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFF7879F1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0)),
                              ),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Icon(Icons.account_box, size: 40),
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
                    Get.to(() => ClientCreateRequest());
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
