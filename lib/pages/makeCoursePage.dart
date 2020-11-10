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
  var _controller1 = TextEditingController();
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
      body:Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding( //search
                padding: const EdgeInsets.all(18.0),
                child: TextField(
                  onChanged:(value){

                  },
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: "Search",
                    labelStyle: TextStyle(
                        color: Colors.grey
                    ),
                    prefixIcon: IconButton(
                      icon: Icon(Icons.search),
                      color: Colors.grey,
                    ),
                    suffixIcon: IconButton(
                      onPressed: ()=> _controller.clear(),
                      icon: Icon(Icons.clear),
                      color : Colors.grey,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        borderSide: BorderSide(color: Colors.grey)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        borderSide: BorderSide(color: Colors.grey)
                    ),
                  ),

                ),
              ),
              Padding( //add spots to make course
                  padding: EdgeInsets.only(left:38, bottom: 14,top: 325),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:<Widget>[
                        Icon(
                          Icons.add_circle,
                          color: Colors.blue,
                          size: 45,
                        ),
                        Padding(padding: EdgeInsets.only(left:10, )),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.blue,
                          size: 30,
                        ),
                        Padding(padding: EdgeInsets.only(left:10, )),
                        Icon(
                          Icons.add_circle,
                          color: Colors.blue,
                          size: 45,
                        ),
                        Padding(padding: EdgeInsets.only(left:10, )),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.blue,
                          size: 30,
                        ),
                        Padding(padding: EdgeInsets.only(left:10, )),
                        Icon(
                          Icons.add_circle,
                          color: Colors.blue,
                          size: 45,
                        ),
                        Padding(padding: EdgeInsets.only(left:10, )),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.blue,
                          size: 30,
                        ),
                        Padding(padding: EdgeInsets.only(left:10, )),
                        Icon(
                          Icons.add_circle,
                          color: Colors.blue,
                          size: 45,
                        ),
                      ]
                  )
              ),
              Container( //course detail setting
                  height: 110,
                  width: 390,
                  margin: EdgeInsets.only(left:25,right:25,bottom:12),
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
                                        //labelText: 'Type your Number',
                                        hintText: 'Course name',/*
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black,)
                                        )*/
                                      ),
                                      onChanged: (value) {
                                      },
                                      controller: _controller1,

                                    )
                                ),
                                Container(
                                  margin: EdgeInsets.only(left:15, top:15),
                                  child: Row(
                                      children:[
                                        Text('테마:  ',style: GoogleFonts.inter(
                                          fontSize:18,
                                          color: Colors.black54
                                        ), ),
                                        Text('데이트 코스',style: GoogleFonts.inter(
                                          fontSize:18,
                                          color: Colors.black54
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
                                top: 38,
                                child: Icon(
                                  Icons.check_circle,
                                  color: Colors.black,
                                  size: 40,
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
        )
      )

    );
  }
}
