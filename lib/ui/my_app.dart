
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reparapp/ui/pages/login.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Authentication Flow',
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFE8E9FC)),
      //home: Content(),
      //home: SignUpPage(),
      home: LoginPage(),
    );
  }
}