import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "ReparApp",
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
                        border: InputBorder.none,
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
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Log In",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF7879F1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  child: Text("Use FingerPrint",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                  minWidth: double.maxFinite,
                  color: Color(0xFF7879F1),
                ),
                MaterialButton(
                  onPressed: () {},
                  child: Text("Use Face to Log In",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                  minWidth: double.maxFinite,
                  color: Color(0xFF7879F1),
                ),
              ],
            )),
          ),
          TextButton(
              onPressed: () {},
              child: Text("Are you fixer? Log In",
                  style: TextStyle(fontSize: 16, color: Color(0xFFA5A6F6)))),
          TextButton(
              onPressed: () {},
              child: Text("Don't have an account? Sign up",
                  style: TextStyle(fontSize: 16, color: Color(0xFFA5A6F6))))
        ],
      ),
    ));
  }
}
