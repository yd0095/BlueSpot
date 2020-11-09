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
      body: Container( //코스 정보 표시하는 container
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
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container( //코스 분류
                    margin: EdgeInsets.all(2),
                    child: Row(
                        children:[
                          Text('코스 분류:  ',style: GoogleFonts.inter(
                            fontSize:18,
                            fontWeight: FontWeight.bold,
                          ), ),
                          Text('먹방 코스',style: GoogleFonts.inter(
                            fontSize:18,
                            fontWeight: FontWeight.bold,
                          ), )
                        ]
                    ),
                  ),
                  Container( //코스 등록자
                    margin: EdgeInsets.all(2),
                    child: Row(
                        children:[
                          Text('코스 등록자:  ',style: GoogleFonts.inter(
                            fontSize:18,
                            fontWeight: FontWeight.bold,
                          ), ),
                          Text('비룡',style: GoogleFonts.inter(
                            fontSize:18,
                            fontWeight: FontWeight.bold,
                          ), )
                        ]
                    ),
                  ),
                  Container( //예상 소요시간
                    margin: EdgeInsets.all(2),
                    child: Row(
                        children:[
                          Text('예상 소요시간:  ',style: GoogleFonts.inter(
                            fontSize:18,
                            fontWeight: FontWeight.bold,
                          ), ),
                          Text('1시간 30분',style: GoogleFonts.inter(
                            fontSize:18,
                            fontWeight: FontWeight.bold,
                          ), )
                        ]
                    ),
                  ),
                ],

              ),

            ),
            Expanded( //코스 정보 수정 버튼
              child: Stack(
                //alignment: Alignment.center,
                children: [
                  Positioned(
                    right: 20,
                    top: 45,
                    child: Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            )
          ],
        ) ,
      ),

    );
  }
}