import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reparapp/UI/client_UI/client_login.dart';
import 'package:reparapp/domain/controller/firestore_controller.dart';
import 'fixer_signup.dart';

class FixerLogIn extends StatefulWidget {
  const FixerLogIn({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<FixerLogIn> {
  Future<bool> _login() async {
    try {
      if (emailController.text != "" || passwordController.text != "") {
        FirestoreController _firestoreController = Get.find();

        _firestoreController
            .isFixer(emailController.text, passwordController.text, "fixer")
            .then((value) {
          if (value == "incorrect") {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      'You are not a fixer, please login in the initial login view')),
            );
            return Future.value(false);
          } else {
            if (value == "invalid-email") {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("invalid email")),
              );
              return Future.value(false);
            } else {
              if (value == "wrong-password") {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("wrong password")),
                );
                return Future.value(false);
              } else {
                if (value == "user-not-found") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("user not found")),
                  );
                  return Future.value(false);
                } else {
                  printInfo(info: "entra");
                  logged = true;
                  return Future.value(true);
                }
              }
            }
          }
        });
        return Future.value(false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter your user and password')),
        );
        return Future.value(false);
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
        return Future.value(false);
      } else if (e.code == 'wrong-password') {
        print("wrong-password");
        Get.snackbar(
          'wrong-password',
          'Error',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
        );
        return Future.value(false);
      }
      return Future.value(false);
    }
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool logged = false;
  bool _isObscure = true;

  @override
  void initState() {
    _isObscure = true;
    logged = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "HomeTech",
                style: TextStyle(fontFamily: 'Inder', fontSize: 48),
              ),
              const Text(
                "Log In",
                style: TextStyle(fontSize: 30),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Form(
                    child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
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
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: TextFormField(
                        obscureText: _isObscure,
                        controller: passwordController,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
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
                        onPressed: () async {
                          await _login();
                          if (logged) {
                            Get.back();
                          }
                        },
                        child: Text("Log In",
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                        minWidth: double.maxFinite,
                        color: Color(0xFF7879F1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0)),
                        height: 50,
                      ),
                    ),
                  ],
                )),
              ),
              TextButton(
                  onPressed: () {
                    Get.to(() => FixerSignUp());
                  },
                  child: Text("Don't have an account? Sign up as fixer",
                      style:
                          TextStyle(fontSize: 16, color: Color(0xFFA5A6F6)))),
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("Back to login as a client",
                      style:
                          TextStyle(fontSize: 16, color: Color(0xFFA5A6F6)))),
            ],
          ),
        ));
  }
}

class FirebaseLogin2 {}
