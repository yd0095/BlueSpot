import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:bluespot/pages/mainPage.dart';

class CourseThemePage extends StatefulWidget {
  @override
  _CourseThemePageState createState() => _CourseThemePageState();
}

class _CourseThemePageState extends State<CourseThemePage> {
  Color lightSkyblue = Color(0xFFBBDEFB);
  Color lightblue = Color(0xFFE1F5FE);
  final courseTheme = [
    '데이트 코스',
    '먹방 코스',
    '오락 코스',
    '힐링 코스',
    '추억여행 코스',
    '운동 코스',
    '쇼핑 코스',
    '대학가 주변 코스',
    '유명지 코스'
  ];
  List<bool> check = new List<bool>();

  @override
  void initState() {
    setState(() {
      for (int i = 0; i < courseTheme.length; i++) {
        check.add(false);
      }
    });
  }

  void checkChange(bool val, int index) {
    setState(() {
      check[index] = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('관심 코스 테마 설정',
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
      body: new ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: courseTheme.length,
        itemBuilder: (BuildContext context, int index) {
          return new Container(
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Color(0xFFF1F9FF),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: new EdgeInsets.all(7),
            child: new Column(children: <Widget>[
              new CheckboxListTile(
                  value: check[index],
                  title: new Text('${courseTheme[index]}',
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      )),
                  controlAffinity: ListTileControlAffinity.trailing,
                  onChanged: (bool val) {
                    checkChange(val, index);
                  }),
            ]),
          );
        },
      ),
    );
  }
}
