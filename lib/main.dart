import 'package:bluespot/pages/errorPage.dart';
import 'package:bluespot/pages/googleAuthentication.dart';
import 'package:bluespot/pages/makeCoursePage.dart';
import 'package:bluespot/pages/manageCoursePage.dart';
import 'package:bluespot/pages/myEnrolledDetailPage.dart';
import 'package:bluespot/pages/myPage.dart';
import 'package:bluespot/pages/spotMakePage.dart';
import 'package:flutter/material.dart';
import 'package:bluespot/pages/mainPage.dart';
import 'package:bluespot/pages/mapPage.dart';
import 'package:bluespot/pages/splashPage.dart';
import 'package:bluespot/pages/spotPage.dart';
import 'package:bluespot/pages/loginPage.dart';
import 'package:bluespot/pages/courseThemePage.dart';
import 'package:bluespot/pages/myEnrolledPage.dart';
import 'package:bluespot/pages/settingPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  //처음에 시작할때 firebase도 초기화하고 같이 바인딩해줘야 해서 필요한 부분. 삭제하면 어플 동작안해요ㅠ.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

//StatelessWidget
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primarySwatch: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // appBarTqheme: AppBarTheme(
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
        '/clickMyCourse' : (BuildContext context) => MyEnrolledDetailPage(),
        '/clickCourseMake' : (BuildContext context) => MakeCoursePage(),
        '/manageCoursePage' : (BuildContext context) => ManageCoursePage(),
        '/errorPage' : (BuildContext context) => ErrorPage(),
        '/toSettingPage' : (BuildContext context) => SettingPage(),
        '/toSpotMakePage' : (BuildContext context) => SpotMakePage(),
      },
    );
  }
}
