import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:bluespot/pages/mainPage.dart';

class SpotPage extends StatefulWidget {
  @override
  _SpotPageState createState() => _SpotPageState();
}

class _SpotPageState extends State<SpotPage> {
  Color lightSkyblue = Color(0xFFBBDEFB);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

          title: Text('Spot Page', style: TextStyle(
              color: Colors.blue, fontWeight: FontWeight.bold)),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          iconTheme: new IconThemeData(color: Colors.grey),
          actions: [
            Icon(Icons.more_vert,),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 8)
            ),
          ]
      ),

      body: Stack(
        children: <Widget>[
          Container(
            height:800,
            child: MediaQuery.removePadding(context: context,
                removeTop: true,
                child: ListView(
                  children: <Widget>[
                    Container(
                      height: 80,
                      margin: EdgeInsets.only(top:35),
                      color: Colors.white,
                      //color: lightSkyblue,
                      child: Container(
                        margin: EdgeInsets.only(left:30,bottom:1),
                        child:Row(
                          children:<Widget>[
                            Container( //profile photo
                              height: 65,
                              width: 65,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(image: AssetImage('lib/images/b.jpg'), fit: BoxFit.contain),
                                //color: Colors.blue
                              ),
                            ),
                            Expanded( //name, email
                              child:Container(
                                padding: EdgeInsets.only(left:15, right:10),
                                child:Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        children:<Widget> [
                                          Text(
                                            '비룡',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 20
                                            ),
                                          ),
                                        ],
                                      ),
                                      height:35
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom:10),
                                      child:Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            '12172919@inha.edu',
                                            style: TextStyle(
                                              fontSize:17, color:Colors.grey
                                            )
                                          ),

                                        ]
                                      ),
                                      height: 25,
                                    )
                                  ],
                                )
                              )
                            ),
                          ]
                        )
                      )
                    ),
                    Container( //spot photo
                      margin: EdgeInsets.only(left:25,right:25),
                      height:200,
                      width:360,
                      decoration: BoxDecoration(
                        color: lightSkyblue,
                        border: Border.all(width: 0.1),
                      ),
                    ),
                    Container( //number of heart
                      margin: EdgeInsets.only(left:25,right:25),
                      height:70,
                      width:360,
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.black54,
                              blurRadius: 1.0,
                              offset: Offset(0, 0)
                          )
                        ],
                        color: Colors.white,
                        border: Border.all(width: 0.2),
                        //image: DecorationImage(image:Image,fit: BoxFit.contain)
                      ),
                      child: Row(
                              children:[
                                IconButton(
                                  icon: Icon(EvaIcons.heart , color: Colors.red,),
                                  iconSize: 20,
                                ),
                                Text('109',style: GoogleFonts.inter(
                                  fontSize:18,
                                  fontWeight: FontWeight.w500,
                                ), ),
                                IconButton(
                                  icon: Icon(Icons.more_vert , color: Colors.black,),
                                  iconSize: 20,
                                  padding: EdgeInsets.only(left:250)
                                ),
                              ]
                          )
                      ),
                    Container( //spot name, location, explanation
                      height: 250,
                      margin: EdgeInsets.only(top:30,left:30,right:30),
                      color: Colors.white,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                        '해운대 앞 바다',style: GoogleFonts.inter(
                        fontSize:20,
                        fontWeight: FontWeight.bold,
                          ),),
                          Text(
                            '부산 해운대구 우동',style: GoogleFonts.inter(
                            fontSize:17,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),),
                          Padding(
                            padding:EdgeInsets.all(10)
                          ),
                          Text(
                            '부산 해운대구 중동, 좌동, 우동에 걸쳐 있는 해수욕장. 수심이 얕고 조수의 변화도 심하지 않아 해수욕장으로서의 조건이 좋다.',
                            style: GoogleFonts.inter(
                            fontSize:18,
                            fontWeight: FontWeight.w500,
                          ),
                          )
                        ]
                      ),
                    ),
                    Padding( //comment
                      padding: EdgeInsets.only(left:25),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:<Widget>[
                          Text('COMMENT', style: GoogleFonts.inter(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color:Colors.blue
                          )),
                          Padding(
                            padding: EdgeInsets.all(10)
                          ),
                          Text('린다G', style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          )),
                          Text(
                              '저도 코로나 끝나면 가보고 싶어요!', style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                          ),),
                          Padding(
                              padding: EdgeInsets.all(5)
                          )
                        ]
                      )
                    )
                  ]
                ))
          ),

        ]
      )
    );
  }
}