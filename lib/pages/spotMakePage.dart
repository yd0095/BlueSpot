import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:bluespot/pages/mainPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

class SpotMakePage extends StatefulWidget {
  final String uid;
  final User loggeduser;
  //final File file1;
  final String address;

  SpotMakePage({Key key, @required this.uid, this.loggeduser,this.address}) : super(key: key);
  @override
  _SpotMakePageState createState() => _SpotMakePageState(uid,loggeduser,address);
}
/*
class Arguments{
  String address;
  Future<File> photo;
  Arguments(this.address,this.photo);
}*/
class _SpotMakePageState extends State<SpotMakePage> {
  Color lightSkyblue = Color(0xFFBBDEFB);
  final String uid;
  final User loggeduser;
  //final File file1;
  final String address;

  _SpotMakePageState(this.uid,this.loggeduser,this.address);

  @override
  Widget build(BuildContext context) {
    //final Map<String,File>args = ModalRoute.of(context).settings.arguments;
    //File _file = args['photo'];

    return Scaffold(
      appBar: AppBar(
          title: Text('스팟 등록하기', style: TextStyle(
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
                          Padding(
                            padding: EdgeInsets.all(20),
                          ),
                          Container( //spot photo
                            margin: EdgeInsets.only(left:25,right:25),
                            height:300,
                            width:360,
                            decoration: BoxDecoration(
                              color: lightSkyblue,
                              border: Border.all(width: 0.1),
/*
                              image: DecorationImage(
                                image: FileImage(File(file1.path)),
                                fit: BoxFit.fill
                              )*/
                            ),
                          ),/*
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
                          ),*/
                          Container( //spot name, location, explanation
                            height: 360,
                            margin: EdgeInsets.only(top:30,left:30,right:30),
                            color: Colors.white,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextField(
                                    maxLength: 20,
                                    decoration: InputDecoration(
                                      hintText: 'spot명을 작성하세요.',
                                    ),
                                  ),

                                  TextField(
                                    maxLength: 40,
                                    decoration: InputDecoration(
                                      hintText: 'spot의 주소를 작성하세요.',
                                    ),
                                  ),
                                  //Text(args['photo']),
                                  Padding(
                                      padding:EdgeInsets.all(10)
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(1),
                                      child: TextField(
                                        minLines: 5,
                                        maxLines: 10,
                                        maxLength:200,
                                        autocorrect: false,
                                        decoration: InputDecoration(
                                          hintText: 'spot에 대한 설명을 작성하세요.',
                                          filled: true,
                                          fillColor: Color(0xFFEEEEEE),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                            borderSide: BorderSide(color: Colors.grey),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                            borderSide: BorderSide(color:Colors.white),
                                          ),
                                        ),
                                      )
                                    )
                                  ),
                                ]
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 45,
                            margin: EdgeInsets.only(left: 76,right: 76),
                              child: GestureDetector(
                                onTap: () {/*
                                  Navigator.pushNamed(context,
                                      '/clickSpot',
                                      arguments: <String, File>{
                                        'photo' : _file
                                      }
                                  );*/
                                },
                                  child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                      Positioned(
                                      left: 0,
                                      top: 0,
                                      right: 0,

                                        child: Container(
                                          height: 45,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: Color(0xFF2699FB),
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                              BorderRadius.all(Radius.circular(10.0))),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(left: 70),
                                                child: Text(
                                                  "SPOT 등록하기",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Arial",
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                        Positioned(
                                          top: 11,
                                          right: 14,
                                          child: Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ]
                                  )
                              )
                          ),
                          Padding(padding:EdgeInsets.all(20)),


                        ]
                    ))
            ),

          ]
      )
    );
  }
}