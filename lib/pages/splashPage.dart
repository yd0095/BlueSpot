import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bluespot/pages/mainPage.dart';
import 'package:bluespot/pages/loginPage.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((value) {
      Navigator.of(context).pushReplacementNamed('/AfterSplash');
    });
  }
  @override
  Widget build(BuildContext context) {
   return Container(
      color: Colors.white,
      child: SizedBox(
        width: 100,
        height: 100,
        child: Image.asset('lib/images/BlueSpot.png'),
        ),
    );
  }
}


