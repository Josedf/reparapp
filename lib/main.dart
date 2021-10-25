import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reparapp/UI/client_UI/client_counter_offer.dart';
import 'package:reparapp/UI/client_UI/client_profile_fixer.dart';

import 'package:flutter/services.dart';
import 'package:reparapp/UI/fixer_UI/fixer_counter_offer.dart';

import 'package:reparapp/UI/fixer_UI/fixer_login.dart';
import 'package:reparapp/UI/fixer_UI/fixer_request_state.dart';
import 'package:reparapp/UI/fixer_UI/fixer_set_offer.dart';

import 'UI/client_UI/client_login.dart';
import 'UI/client_UI/client_map.dart';
import 'UI/client_UI/client_profile.dart';
import 'UI/fixer_UI/fixer_edit_profile.dart';
import 'UI/fixer_UI/fixer_profile.dart';
import 'UI/fixer_UI/fixer_signup.dart';
import 'firebase/firebase_central.dart';

void main() {
  // this is the key
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFE8E9FC),
          fontFamily: 'Inder'),
      routes: {
        '/loginClient': (context) => const ClientLogIn(),
        '/signupFixer': (context) => const FixerSignUp(),
        '/loginFixer': (context) => const FixerLogIn()
      },
      home: Scaffold(
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
                //return GoogleCentral();
                return FixerRequest();
              }

              return Loading();
            },
          )),
    );
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
