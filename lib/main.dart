import 'package:bluespot/pages/myPage.dart';
import 'package:flutter/material.dart';
import 'package:bluespot/pages/mainPage.dart';
import 'package:bluespot/pages/mapPage.dart';
import 'package:bluespot/pages/splashPage.dart';
import 'package:bluespot/pages/spotPage.dart';
import 'package:bluespot/pages/loginPage.dart';
import 'package:bluespot/pages/courseThemePage.dart';
import 'package:bluespot/pages/myEnrolledPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primarySwatch: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // appBarTheme: AppBarTheme(
        //     color: Colors.grey.shade50
        // )
      ),
      home: SplashPage(),
      routes: <String, WidgetBuilder>{
        '/clickSpot': (BuildContext context) => SpotPage(),
        '/ToMyPage': (BuildContext context) => MyPage(),
        '/AfterSplash': (BuildContext context) => LoginPage(),
        '/AfterLogin': (BuildContext context) => MainPage(),
        '/clickCourseThemeSetting': (BuildContext context) => CourseThemePage(),
        '/clickMyEnrolledPage' : (BuildContext context) => MyEnrolledPage(),
      },
    );
  }
}
