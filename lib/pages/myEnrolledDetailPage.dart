import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class MyEnrolledDetailPage extends StatefulWidget {
  @override
  _MyEnrolledDetailPageState createState() => _MyEnrolledDetailPageState();
}
class _MyEnrolledDetailPageState extends State<MyEnrolledDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('부평 맛집 투어',
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
      body: Container(
        height: 120,
        width: 390,
        margin: EdgeInsets.only(left:25,right:25,top:450),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: <Widget>[
            Container(

            ),
            Expanded(
              child: Icon(
                Icons.edit,
                color: Colors.black,
              ),
            )
          ],
        ) ,
      ),

    );
  }
}