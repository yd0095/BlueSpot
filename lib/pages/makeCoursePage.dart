import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class MakeCoursePage extends StatefulWidget {
  @override
  _MakeCoursePageState createState() => _MakeCoursePageState();
}
class _MakeCoursePageState extends State<MakeCoursePage> {
  var _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('코스 생성하기',
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
      body:Stack(
        children: [
          Container(
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width:250,
                                margin: EdgeInsets.only(left:15),
                                child: TextField(
                                  decoration: InputDecoration(
                                    // labelText: 'Type your Number',
                                    hintText: 'Course name',
                                  ),
                                  onChanged: (value) {
                                  },
                                  controller: _controller,

                                )
                            ),
                            Container(
                              margin: EdgeInsets.only(left:15, top:20),
                              child: Row(
                                  children:[
                                    Text('테마:  ',style: GoogleFonts.inter(
                                      fontSize:18,
                                      //fontWeight: FontWeight.w500,
                                    ), ),
                                    Text('데이트 코스',style: GoogleFonts.inter(
                                      fontSize:18,
                                      //fontWeight: FontWeight.w500,
                                    ), )
                                  ]
                              ),
                            )
                          ],
                        )
                    ),
                    Expanded(
                      child: Stack(
                        //alignment: Alignment.center,
                        children: [
                          Positioned(
                            right: 20,
                            top: 45,
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.black,
                              size: 35,
                            ),
                          ),
                        ],
                      ),
                    )
                  ]
              )
          )
        ],
      )

    );
  }
}
