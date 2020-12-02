import 'dart:ui';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:bluespot/pages/mainPage.dart';
import 'package:google_maps_controller/google_maps_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bluespot/pages/mapPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SpotPage2 extends StatefulWidget {
  final String uid;
  final User loggeduser;
  final String marker_id;

  SpotPage2({Key key, @required this.uid, this.loggeduser,this.marker_id}) : super(key: key);

  @override
  _SpotPage2State createState() => _SpotPage2State(uid, loggeduser, marker_id);
}

class _SpotPage2State extends State<SpotPage2> {

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage firestorage = FirebaseStorage.instance;
  Stream<QuerySnapshot> currentStream;

  final String uid;
  final User loggeduser;
  final String marker_id;
  _SpotPage2State(this.uid, this.loggeduser, this.marker_id);

  Color lightSkyblue = Color(0xFFBBDEFB);

  //firestore에서 받아온 정보
  var reply_id;
  var content_info;
  var content_title;
  var content_picture;
  var content_address;
  var like;
  var From;
  var user_email;
  var user_name;
  var user_profile_pic;

  var imageUrl;


  //Future는 그 자체를 리턴하면 Future<String>으로 리턴 되기에 무조건! Future Builder를 사용해서 구간 처리해줘야함.
  Future<String> addImageToFirebase() async {
    String url;
    var ref = firestorage.ref().child('images/spot_images/$content_picture');
    url = (await ref.getDownloadURL());
    return url;

    print("$imageUrl is imageUrl");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("$marker_id is marker_id");

    //위에꺼가 원래
    currentStream = firestore.collection('Spot').where("Marker_id", isEqualTo: this.marker_id).snapshots();
    //currentStream = firestore.collection('Spot').where("Marker_id", isEqualTo: "(MarkerId{value: 1ADFkty9ChLVUfFsa2bb}, MarkerId{value: 6voxAoeZh67dSpfLfw26}, MarkerId{value: 9KDktTqB5D1wo9bEVQhW}, ..., MarkerId{value: 37.44814187497613126.65155369788408}, MarkerId{value: 37.44705666323565126.65093779563904})").snapshots();
    print("$currentStream is currentStream");
    currentStream.forEach((field) {
      field.docs.asMap().forEach((index, data) {
        setState(() {
          //reply_id = field.docs[index]["Content"]["Comment"]["Reply_ID"];
          content_info = field.docs[index]["Content"]["Content_Info"];
          content_title = field.docs[index]["Content"]["Content_Title"];
          content_picture = field.docs[index]["Content"]["Content_picture"];
          content_address = field.docs[index]["Content"]["Content_Address"];
          like = field.docs[index]["Content"]["Content_Like"];
          From = field.docs[index]["From"];

        });
      });
    });

    currentStream = firestore.collection('UserData').where("uid", isEqualTo: From).snapshots();
    currentStream.forEach((field) {
      field.docs.asMap().forEach((index, data) {
        setState(() {
          user_email = field.docs[index]["email"];
          user_name = field.docs[index]["name"];
          user_profile_pic = field.docs[index]["profile_pic"];
        });
      });
    });
  }
  // Widget _decideImageView(){
  //   if(content_picture == null){
  //     return Container( //spot photo
  //       margin: EdgeInsets.only(left:25,right:25),
  //       height:200,
  //       width:360,
  //       decoration: BoxDecoration(
  //         color: lightSkyblue,
  //         border: Border.all(width: 0.1),
  //       ),
  //     );
  //   }
  //   else{
  //     // Image.network(content_picture,width: 360,height:200);
  //     print(content_picture);
  //     return BoxDecoration(
  //       image: NetworkImage(content_picture),
  //     );
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>
                    MainPage(uid: this.uid,loggeduser: this.loggeduser,)));
              },
            ),
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
                                              image: DecorationImage(image: NetworkImage(user_profile_pic), fit: BoxFit.contain),
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
                                                                '$user_name',
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
                                                                  '$user_email',
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
                            //_decideImageView(),
                            // Container(
                            //   decoration: BoxDecoration(
                            //     image: DecorationImage(image: NetworkImage(imageUrl)),
                            //   ),
                            // ),
                            FutureBuilder<Object>(
                                future: addImageToFirebase(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData == false) {
                                    return CircularProgressIndicator();
                                  }
                                  else if (snapshot.hasError) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Error: ${snapshot.error}',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    );
                                  }
                                  else{
                                    return Container( //number of heart
                                      margin: EdgeInsets.only(left:25,right:25),
                                      height:200,
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
                                          image: DecorationImage(image:
                                          (snapshot.data.toString() == null) ? AssetImage('lib/images/60.jpg') : NetworkImage(snapshot.data.toString()),fit: BoxFit.cover)
                                      ),
                                    );

                                  }
                                }
                            ),
                            FutureBuilder<Object>(
                                future: addImageToFirebase(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData == false) {
                                    return CircularProgressIndicator();
                                  }
                                  else if (snapshot.hasError) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Error: ${snapshot.error}',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    );
                                  }
                                  else{
                                    return Container( //number of heart
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
                                          // image: DecorationImage(image:
                                          // (snapshot.data.toString() == null) ? AssetImage('lib/images/60.jpg') : NetworkImage(snapshot.data.toString()),fit: BoxFit.contain)
                                        ),
                                        child: Row(
                                            children:[
                                              IconButton(
                                                icon: Icon(EvaIcons.heart , color: Colors.red,),
                                                iconSize: 20,
                                                onPressed: (){
                                                  String docID;
                                                  setState(() {
                                                    like = like + 1;
                                                  });
                                                  firestore.collection('Spot').where("Marker_id", isEqualTo: this.marker_id)
                                                  .get().then((querySnapshot){

                                                    querySnapshot.docs.forEach((element) {
                                                      //docID = element.id;
                                                      element.reference.update({
                                                        'Content':{
                                                          'Content_Like':like,
                                                          'Content_Address':content_address ,
                                                          'Content_Info': content_info,
                                                          'Content_Title' : content_title,
                                                          'Content_picture':content_picture},
                                                        'Who_Like': FieldValue.arrayUnion([uid])
                                                      });
                                                      //print(element.data());
                                                    });
                                                  });


                                                  print('docID is $docID');
                                                  firestore.collection('Spot').doc(docID).update({
                                                    'Content':{
                                                      'Content_Like' : like
                                                    }
                                                  });
                                                },
                                              ),
                                              Text('$like',style: GoogleFonts.inter(
                                                fontSize:18,
                                                fontWeight: FontWeight.w500,
                                              ), ),
                                              IconButton(
                                                  icon: Icon(Icons.more_vert , color: Colors.black,),
                                                  iconSize: 20,
                                                  padding: EdgeInsets.only(left:250),
                                              ),
                                            ]
                                        )
                                    );

                                  }

                                }
                            ),
                            Container( //spot name, location, explanation
                              height: 250,
                              margin: EdgeInsets.only(top:30,left:30,right:30),
                              color: Colors.white,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      content_title,style: GoogleFonts.inter(
                                      fontSize:20,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                    // Text(
                                    //   '아직 미구현',style: GoogleFonts.inter(
                                    //   fontSize:17,
                                    //   color: Colors.grey,
                                    //   fontWeight: FontWeight.w500,
                                    // ),),
                                    Padding(
                                        padding:EdgeInsets.all(10)
                                    ),
                                    Text(
                                      content_info,
                                      style: GoogleFonts.inter(
                                        fontSize:18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ]
                              ),
                            ),
                            // Padding( //comment
                            //   padding: EdgeInsets.only(left:25),
                            //   child:Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children:<Widget>[
                            //       Text('COMMENT', style: GoogleFonts.inter(
                            //         fontSize: 22,
                            //         fontWeight: FontWeight.bold,
                            //         color:Colors.blue
                            //       )),
                            //       Padding(
                            //         padding: EdgeInsets.all(10)
                            //       ),
                            //       // Text(reply_id, style: GoogleFonts.inter(
                            //       //     fontSize: 18,
                            //       //     fontWeight: FontWeight.bold
                            //       // )),
                            //       Text(
                            //           '여기도 없음', style: GoogleFonts.inter(
                            //           fontSize: 16,
                            //           fontWeight: FontWeight.w500,
                            //       ),),
                            //       Padding(
                            //           padding: EdgeInsets.all(5)
                            //       )
                            //     ]
                            //   )
                            // )
                          ]
                      ))
              ),

            ]
        )
    );
  }
}