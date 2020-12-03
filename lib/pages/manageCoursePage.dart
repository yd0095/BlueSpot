
import 'package:bluespot/pages/mapPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bluespot/pages/recommend.dart';
import 'package:bluespot/pages/pickMarkersPage.dart';


import 'mainPage.dart';
import 'myEnrolledPage.dart';

class ManageCoursePage extends StatefulWidget {

  final String uid;
  final User loggeduser;

  ManageCoursePage({Key key, @required this.uid, this.loggeduser,}) : super(key: key);
  @override
  _ManageCoursePageState createState() => _ManageCoursePageState(uid, loggeduser);

}

class _ManageCoursePageState extends State<ManageCoursePage> {
  final String uid;
  final User loggeduser;

  _ManageCoursePageState(this.uid, this.loggeduser);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>
                    MainPage(uid: this.uid, loggeduser: this.loggeduser,)));
              }
          ),
          title: Text('코스 관리하기',
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          iconTheme: new IconThemeData(color: Colors.grey),
          actions: [
            Icon(
              Icons.more_vert,
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
          ]),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 65,
              margin: EdgeInsets.only(left: 16, top: 32, right: 16),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>
                      PickPage(uid: this.uid,loggeduser: this.loggeduser,)));
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 65,
                      decoration: BoxDecoration(
                          color: Color(0xFFF1F9FF),
                          border: Border.all(
                            color: Colors.black,
                            width: 2.0,
                          ),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 65),
                            child: Text(
                              "코스 생성하기",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Arial",
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),

                    ),
                  ),
                  Positioned(
                    top: 21,
                    left: 20,
                    child: Icon(
                      Icons.location_on,
                      color: Colors.grey[850],
                    ),
                  ),
                  Positioned(
                    top: 21,
                    right: 27,
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.grey[850],
                    ),
                  ),
                ],
              ),)
            ),
            // Container(
            //     height: 65,
            //     margin: EdgeInsets.only(left: 16, top: 26, right: 16),
            //     child: GestureDetector(
            //       onTap: () {
            //         Navigator.pushNamed(context, '/clickCourseThemeSetting');
            //       },
            //       child: Stack(
            //         alignment: Alignment.center,
            //         children: [
            //           Positioned(
            //               left: 0,
            //               top: 0,
            //               right: 0,
            //               child: Container(
            //                 height: 65,
            //                 decoration: BoxDecoration(
            //                     color: Color(0xFFF1F9FF),
            //                     border: Border.all(
            //                       color: Colors.black,
            //                       width: 2.0,
            //                     ),
            //                     borderRadius:
            //                         BorderRadius.all(Radius.circular(10.0))),
            //                 child: Column(
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Container(
            //                       margin: EdgeInsets.only(left: 65),
            //                       child: Text(
            //                         "관심코스 테마 설정",
            //                         textAlign: TextAlign.left,
            //                         style: TextStyle(
            //                           color: Colors.black,
            //                           fontFamily: "Arial",
            //                           fontWeight: FontWeight.w700,
            //                           fontSize: 15,
            //                         ),
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               )),
            //           Positioned(
            //             top: 21,
            //             left: 20,
            //             child: Icon(
            //               Icons.apps,
            //               color: Colors.grey[850],
            //             ),
            //           ),
            //           Positioned(
            //             top: 21,
            //             right: 27,
            //             child: Icon(
            //               Icons.arrow_forward,
            //               color: Colors.grey[850],
            //             ),
            //           ),
            //         ],
            //       ),
            //     )),
            Container(
              height: 65,
              margin: EdgeInsets.only(left: 16, top: 29, right: 16),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyEnrolledPage(uid: this.uid,loggeduser: this.loggeduser,),
                      ));
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      right: 0,
                      child: Container(
                        height: 65,
                        decoration: BoxDecoration(
                            color: Color(0xFFF1F9FF),
                            border: Border.all(
                              color: Colors.black,
                              width: 2.0,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 65),
                              child: Text(
                                "내가 등록한 코스 보기",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Arial",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 21,
                      left: 20,
                      child: Icon(
                        Icons.zoom_in,
                        color: Colors.grey[850],
                      ),
                    ),
                    Positioned(
                      top: 21,
                      right: 27,
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.grey[850],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 65,
              margin: EdgeInsets.only(left: 16, top: 31, right: 16),
              child: GestureDetector(
                onTap: () {
                  // Navigator.of(context).popUntil((route) => route.isFirst);
                  // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>
                  //     Recommend(uid: this.uid,loggeduser: this.loggeduser,)));
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>
                      Recommend(uid: this.uid,loggeduser: this.loggeduser,)));
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      right: 0,
                      child: Container(
                        height: 65,
                        decoration: BoxDecoration(
                            color: Color(0xFFF1F9FF),
                            border: Border.all(
                              color: Colors.black,
                              width: 2.0,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 65),
                              child: Text(
                                "자동 코스 추천",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Arial",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 21,
                      left: 20,
                      child: Icon(
                        Icons.map,
                        color: Colors.grey[850],
                      ),
                    ),
                    Positioned(
                      top: 21,
                      right: 27,
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.grey[850],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
