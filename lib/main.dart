import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reparapp/UI/client_UI/client_counter_offer.dart';
import 'package:reparapp/UI/client_UI/client_fix_offer.dart';
import 'package:reparapp/UI/client_UI/client_images.dart';
import 'package:reparapp/UI/client_UI/client_profile_fixer.dart';
import 'package:reparapp/mock_image64.dart';
import 'package:flutter/services.dart';
import 'package:reparapp/UI/fixer_UI/fixer_counter_offer.dart';

import 'package:reparapp/UI/fixer_UI/fixer_login.dart';
import 'package:reparapp/UI/fixer_UI/fixer_map.dart';
import 'package:reparapp/UI/fixer_UI/fixer_request_state.dart';
import 'package:reparapp/UI/fixer_UI/fixer_set_offer.dart';
import 'package:reparapp/domain/use_case/firestore_service.dart';

import 'UI/client_UI/client_login.dart';
import 'UI/client_UI/client_map.dart';
import 'UI/client_UI/client_profile.dart';
import 'UI/fixer_UI/fixer_edit_profile.dart';
import 'UI/fixer_UI/fixer_profile.dart';
import 'UI/fixer_UI/fixer_signup.dart';
import 'domain/controller/firestore_controller.dart';
import 'domain/controller/location_controller.dart';
import 'domain/use_case/locator_service.dart';
import 'firebase/firebase_central.dart';

void main() {
  Get.lazyPut<FirestoreService>(() => FirestoreService());
  Get.lazyPut<FirestoreController>(() => FirestoreController());
  Get.put(LocatorService());
  Get.put(LocationController());
  // this is the key
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String mockImage = "";

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFFE8E9FC),
            fontFamily: 'Inder'),
        routes: {
          '/loginClient': (context) => const ClientLogIn(),
          '/signupFixer': (context) => const FixerSignUp(),
          '/loginFixer': (context) => const FixerLogIn(),
          //'/profile': (context) => const ClientProfile(),
          '/profile': (context) => const FirebaseCentral(),
          '/profileFixer': (context) => const FixerProfile()
        },
        home: SafeArea(
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: null,
              body: FutureBuilder(
                future: _initialization,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print("error ${snapshot.error}");
                    return Wrong();
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    //return FixerMap();
                    return FirebaseCentral();
                    /*return ClientFixOffer(
                        title: "Im a title",
                        image64List: getMockImage64(),
                        price: "5000");*/
                  }

                  return Loading();
                },
              )),
        ));
  }
}

class Wrong extends StatelessWidget {
  //const Wrong({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Something went wrong")),
    );
  }
}

class Loading extends StatelessWidget {
  //const Loading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Loading")),
    );
  }
}
