import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:bluespot/pages/mainPage.dart';

class MyEnrolledPage extends StatefulWidget {
  @override
  _MyEnrolledPageState createState() => _MyEnrolledPageState();
}

class _MyEnrolledPageState extends State<MyEnrolledPage> {

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
        itemCount: courseTheme.length,
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
                Navigator.pushNamed(context, '/clickMyCourse');
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
                    title: '${courseName[index]}',
                    location: '${courseLocation[index]}',
                    theme: '${courseTheme[index]}',
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
    this.theme,
  });

  final Widget icon;
  final String title;
  final String location;
  final String theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
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
              theme: theme,
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
    this.theme,
  }) : super(key: key);

  final String title;
  final String location;
  final String theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            location,
            style: const TextStyle(fontSize: 10.0),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            theme,
            style: const TextStyle(fontSize: 10.0),
          ),
        ],
      ),
    );
  }
}
