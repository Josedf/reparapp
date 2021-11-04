import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reparapp/UI/fixer_UI/fixer_login.dart';
import 'package:reparapp/UI/fixer_UI/fixer_signup.dart';
import 'package:reparapp/domain/controller/firestore_controller.dart';
import 'client_signup.dart';
//import 'package:get/get.dart';

class ClientLogIn extends StatefulWidget {
  const ClientLogIn({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<ClientLogIn> {
  _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  _login() async {
    try {
      if (emailController.text != "" || passwordController.text != "") {
        FirestoreController _firestoreController = Get.find();

        _firestoreController
            .isFixer(emailController.text, passwordController.text, "client")
            .then((value) {
          //printInfo(info: value);
          if (value == "incorrect") {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      'You are not a client, please press the login fixer button')),
            );
          } else {
            if (value == "invalid-email") {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("invalid email")),
              );
            } else {
              if (value == "wrong-password") {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("wrong password")),
                );
              } else {
                if (value == "user-not-found") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("user not found")),
                  );
                }
              }
            }
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter your user and password')),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("user-not-found");
        Get.snackbar(
          'User not found',
          'Error',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
        );
      } else if (e.code == 'wrong-password') {
        print("wrong-password");
        Get.snackbar(
          'wrong-password',
          'Error',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
        );
      }
    }
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isObscure = true;

  @override
  void initState() {
    _isObscure = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "ReparApp",
            style: TextStyle(fontFamily: 'Inder', fontSize: 40),
          ),
          const Text(
            "Log In",
            style: TextStyle(fontSize: 30),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Form(
                child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        //round border without outline
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 0.0,
                          ),
                        ),
                        filled: true,
                        fillColor: Color(0xFFF6F6F6),
                        labelText: 'Email'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 20.0),
                  child: TextFormField(
                    obscureText: _isObscure,
                    controller: passwordController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 0.0,
                          ),
                        ),
                        filled: true,
                        fillColor: Color(0xFFF6F6F6),
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: MaterialButton(
                    onPressed: () {
                      _login();
                    },
                    child: Text("Log In",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                    minWidth: double.maxFinite,
                    color: Color(0xFF7879F1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0)),
                    height: 50,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: MaterialButton(
                      onPressed: () {},
                      child: Text("Use FingerPrint",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                      minWidth: double.maxFinite,
                      color: Color(0xFF7879F1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0)),
                      height: 50,
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: MaterialButton(
                      onPressed: () {},
                      child: Text("Use Face to Log In",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                      minWidth: double.maxFinite,
                      color: Color(0xFF7879F1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0)),
                      height: 50,
                    )),
              ],
            )),
          ),
          TextButton(
              onPressed: () {
                Get.to(() => FixerLogIn());
              },
              child: Text("Are you fixer? Log In",
                  style: TextStyle(fontSize: 16, color: Color(0xFFA5A6F6)))),
          TextButton(
              onPressed: () {
                Get.to(() => ClientSignUp());
              },
              child: Text("Don't have an account? Sign up as client",
                  style: TextStyle(fontSize: 16, color: Color(0xFFA5A6F6)))),
        ],
      ),
    );
  }
}
