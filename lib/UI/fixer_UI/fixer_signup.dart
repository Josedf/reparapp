import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'fixer_login.dart';

class FixerSignUp extends StatefulWidget {
  const FixerSignUp({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<FixerSignUp> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  String dropdownValue = 'Select your category';

  bool _isObscure = true;

  @override
  void initState() {
    _isObscure = true;
    super.initState();
  }

  Future<bool> _signup(BuildContext context) async {
    if (nameController.text == "" || nameController.text.isEmpty) {
      Get.snackbar('Error', 'Please write a name',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color(0xFF808080),
          colorText: Colors.white,
          borderRadius: 10,
          margin: EdgeInsets.all(10),
          snackStyle: SnackStyle.FLOATING,
          duration: Duration(seconds: 3));
      return false;
    }

    if (emailController.text == "" || emailController.text.isEmpty) {
      Get.snackbar('Error', 'Please write an email',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color(0xFF808080),
          colorText: Colors.white,
          borderRadius: 10,
          margin: EdgeInsets.all(10),
          snackStyle: SnackStyle.FLOATING,
          duration: Duration(seconds: 3));
      return false;
    }

    if (passwordController.text == "" || passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Please write a password',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color(0xFF808080),
          colorText: Colors.white,
          borderRadius: 10,
          margin: EdgeInsets.all(10),
          snackStyle: SnackStyle.FLOATING,
          duration: Duration(seconds: 3));
      return false;
    }

    if (phoneController.text == "" || phoneController.text.isEmpty) {
      Get.snackbar('Error', 'Please write a phone number',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color(0xFF808080),
          colorText: Colors.white,
          borderRadius: 10,
          margin: EdgeInsets.all(10),
          snackStyle: SnackStyle.FLOATING,
          duration: Duration(seconds: 3));
      return false;
    }

    if (dropdownValue == "Select your category") {
      Get.snackbar('Error', 'Please select a category',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color(0xFF808080),
          colorText: Colors.white,
          borderRadius: 10,
          margin: EdgeInsets.all(10),
          snackStyle: SnackStyle.FLOATING,
          duration: Duration(seconds: 3));
      return false;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      final _firestore = FirebaseFirestore.instance;
      await _firestore.collection("users").add({
        "name": nameController.text,
        "email": emailController.text,
        "type": "fixer",
        "phone": phoneController.text,
        "category": dropdownValue,
      });
      //_logout();
      Get.snackbar('Success', 'Created succesfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color(0xFFA5A6F6),
          colorText: Colors.white,
          borderRadius: 10,
          margin: EdgeInsets.all(10),
          snackStyle: SnackStyle.FLOATING,
          duration: Duration(seconds: 3));
      Get.back();
      return true;
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => FixerLogIn()));

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return false;
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => FixerLogIn()));
    }
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
                "Sign Up",
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
                        controller: nameController,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Color(0xFFF6F6F6),
                            labelText: 'Name'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Color(0xFFF6F6F6),
                            labelText: 'Email'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: TextFormField(
                        obscureText: _isObscure,
                        controller: passwordController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
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
                      child: TextFormField(
                        controller: phoneController,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Color(0xFFF6F6F6),
                            labelText: 'Phone Number'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        items: <String>[
                          'Select your category',
                          'Computadores',
                          'Enfriamiento',
                          'Plomería',
                          'abanicos',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {},
                      child: Text("Upload certificate",
                          style: TextStyle(
                              fontSize: 16, color: Color(0xFF7879F1))),
                      minWidth: double.maxFinite,
                      color: Color(0x9FFFFFFF),
                    ),
                    MaterialButton(
                      onPressed: () {},
                      child: Text("Upload profile picture",
                          style: TextStyle(
                              fontSize: 16, color: Color(0xFF7879F1))),
                      minWidth: double.maxFinite,
                      color: Color(0x9FFFFFFF),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _signup(context);
                        },
                        child: Text("Sign Up",
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF7879F1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                        ),
                      ),
                    )
                  ],
                )),
              ),
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("already have an account? Log in",
                      style:
                          TextStyle(fontSize: 16, color: Color(0xFFA5A6F6)))),
            ],
          ),
        ));
  }
}
