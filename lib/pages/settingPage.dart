import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}
class _SettingPageState extends State<SettingPage> {
  Color lightSkyblue = Color(0xFFBBDEFB);
  Color lightblue = Color(0xFFE1F5FE);
  final courseTheme = [
    '언어 설정하기',
    'fff',
    'eee',
    'ddd',
    'ccc',
    'bbb',
    'aaa',
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
          title: Text('설정',
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          //backgroundColor: Colors.transparent,
          iconTheme: new IconThemeData(color: Colors.grey),
          actions: [
            Icon(
              Icons.more_vert,
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
          ]),
      body:  new ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: courseTheme.length,
        itemBuilder: (BuildContext context, int index) {
          return new Container(
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Color(0xFFF1F9FF),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: new EdgeInsets.all(7),
            child: new Column(children: <Widget>[
              new ListTile(
                  leading: Icon(Icons.settings, color: Colors.black87,),
                  title: new Text('${courseTheme[index]}',
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        //fontWeight: FontWeight.bold,
                      ),),

            ),]
          ));
        },
      ),
    );
  }
}
