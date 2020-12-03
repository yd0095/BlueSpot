import 'package:bluespot/pages/myEnrolledDetailPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:bluespot/pages/mainPage.dart';

import 'manageCoursePage.dart';

class MyEnrolledPage extends StatefulWidget {
  final String uid;
  final User loggeduser;

  MyEnrolledPage({Key key, @required this.uid, this.loggeduser,}) : super(key: key);
  @override
  _MyEnrolledPageState createState() => _MyEnrolledPageState(uid, loggeduser);
}

class _MyEnrolledPageState extends State<MyEnrolledPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage firestorage = FirebaseStorage.instance;
  Stream<QuerySnapshot> currentStream;

  final String uid;
  final User loggeduser;

  _MyEnrolledPageState(this.uid, this.loggeduser);

  void initState(){
    super.initState();

    currentStream = firestore.collection('Course').where("From", isEqualTo: this.uid).snapshots();
    currentStream.forEach((field) {
      field.docs.asMap().forEach((index, data) {
        setState(() {
          addressList.add(field.docs[index]["course_info"]["course_addr"]);
          titleList.add(field.docs[index]["course_info"]["course_name"]);
          courseIdList.add(field.docs[index]["course_id"]);
        });
      });
    });
  }
  List<String> addressList = []; //코스 시작주소 저장하는 리스트
  List<String> titleList = []; //코스 이름 저장하는 리스트
  List<String> courseIdList = [];

  Color lightSkyblue = Color(0xFFBBDEFB);
  Color lightblue = Color(0xFFE1F5FE);

  final courseName = [
    "부평 맛집 투어",
    "인하대 hidden places",
    "동인천 추억여행",
    "청라에서 힐링하기",
    "계양구 등산러 핫플",
    "aaaaa",
    "bbbbb",
    "ccccc",
  ];
  final courseLocation = [
    "인천시 부평구 부평동 201-141번지",
    "인천광역시 미추홀구 인하로 100",
    "인천 동구 솔빛로 51",
    "인천 서구 청라대로 204",
    "인천 계양구 계산동",
    "aaaaa",
    "bbbbb",
    "ccccc",
  ];
  final courseTheme = [
    "먹방 코스",
    "데이트 코스",
    "추억여행 코스",
    "힐링 코스",
    "운동 코스",
    "aaaaa",
    "bbbbb",
    "ccccc",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>
                    ManageCoursePage(uid: this.uid, loggeduser: this.loggeduser,)));
              }
          ),
          title: Text('내가 등록한 코스',
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
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: addressList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Color(0xFFF1F9FF),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(7),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyEnrolledDetailPage(uid: this.uid,loggeduser: this.loggeduser, course_id: this.courseIdList[index])));
              },
              child: Column(
                children: <CustomListItem>[
                  CustomListItem(
                    icon: Container(
                      height: 50,
                      decoration: const BoxDecoration(
                          color: Color(0xFFF1F9FF),
                      ),
                      child: Stack(
                        //alignment: Alignment.center,
                        children: [
                          Positioned(
                            right: 0,
                            top: 21,
                            left: 20,
                            child: Icon(
                              Icons.location_on,
                              color: Colors.grey[850],
                            ),
                          ),
                        ],
                      ),
                    ),
                    title: '${titleList[index]}',
                    location: '${addressList[index]}',
                    //theme: '${courseTheme[index]}',
                  )
                ]),
            )
          );
        },
      ),
    );
  }
}

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    this.icon,
    this.title,
    this.location,
    //this.theme,
  });

  final Widget icon;
  final String title;
  final String location;
  //final String theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0,),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: icon,
          ),
          Expanded(
            flex: 3,
            child: _CourseDescription(
              title: title,
              location: location,
              //theme: theme,
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 16.0,
          ),
        ],
      ),
    );
  }
}

class _CourseDescription extends StatelessWidget {
  const _CourseDescription({
    Key key,
    this.title,
    this.location,
    //this.theme,
  }) : super(key: key);

  final String title;
  final String location;
  //final String theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(3.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15.0,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            location,
            style: const TextStyle(fontSize: 12.0),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          // Text(
          //   theme,
          //   style: const TextStyle(fontSize: 10.0),
          // ),
        ],
      ),
    );
  }
}
