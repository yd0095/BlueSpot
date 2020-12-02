import 'dart:core';
import 'dart:developer';
//import 'dart:html';
import 'package:bluespot/pages/makeCourseAPI.dart';
import 'package:bluespot/pages/spotFromMainPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:bluespot/pages/myPage.dart';
import 'package:bluespot/pages/errorPage.dart';
import 'package:bluespot/pages/spotPage.dart';
import 'package:bluespot/pages/manageCoursePage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kopo/kopo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:bluespot/pages/loginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bluespot/pages/googleAuthentication.dart';
import 'package:bluespot/pages/mapPage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:geocoder/geocoder.dart' as geoCo;
import 'package:geolocator/geolocator.dart';


class MainPage extends StatefulWidget {

  //밑에 2개 아뒤 직접생성하고 로그인할때 필요한거 여기서 받는거.
  final String uid; //유저 아이디. 여기 오려면 uid가 필요하니까 uid를 받는 변수.
  final User loggeduser;  //currentUser를 받기 위한 변수.
  MainPage({Key key, @required this.uid, this.loggeduser,}) : super(key: key);   //superfunction에서 uid를 받는다.
  @override
  //매개변수를 통해 받는것!
  _MainPageState createState() => _MainPageState(uid, loggeduser);
}

class _MainPageState extends State<MainPage> {
  //매개변수 받기위해서 변수2개 생성 + this. 걍 생성자.

  final String uid;
  final User loggeduser;
  _MainPageState(this.uid, this.loggeduser);

  //위치
  Position currentPosition; //내현재위치
  String myCurrentSubLocality;



  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage firestorage = FirebaseStorage.instance;
  Stream<QuerySnapshot> currentStream;
  Stream<QuerySnapshot> currentStream2;
  Stream<QuerySnapshot> currentStream3;

  //메인화면에 띄워줄 가까운 것. sublocality 기준
  List<String> markerId = [];
  

  
  @override
  void initState(){
    //현재위치 파악 => currentPosition;
    getData();
    super.initState();
  }

  Future<List<String>> addImageToFirebase(List imageLinks) async {
    List<String> urlList= [];
    for(int i = 0; i< imageLinks.length; i++) {
      var ref = firestorage.ref().child('images/spot_images/${imageLinks[i]}');
      var v = await ref.getDownloadURL();
      urlList.add(v);
    }
    return urlList;
  }

  getData() async{
    currentlocatePosition();
    //구 주소 확인 => myCurrentSubLocality;
    getCurrentSubLocality();

    //삭제
    var myCurrentLocality = "Incheon";
    myCurrentSubLocality = "Nam-gu";

    currentStream = firestore.collectionGroup(myCurrentLocality).where("sublocality", isEqualTo: myCurrentSubLocality).snapshots();
    currentStream.forEach((field) {
      field.docs.asMap().forEach((index, data) {
        setState(() {
          markerId.add(field.docs[index]["markerId"]);
          print("${field.docs[index]["markerId"]} is it");

          currentStream2 = firestore.collection('Spot')
              .where("Marker_id", isEqualTo: field.docs[index]["markerId"])
              .snapshots();
          currentStream2.forEach((field) {
            field.docs.asMap().forEach((index, data) {
              setState(() {
                itemList.add(field.docs[index]["Content"]["Content_picture"]);
                titleList.add(field.docs[index]["Content"]["Content_Title"]);
                likeList.add(field.docs[index]["Content"]["Content_Like"]);
                print("${field.docs[index]["Content"]["Content_picture"]} is pic");
              });
            });
          });
          // currentStream3 = firestore.collection('Course').where("From", isEqualTo: this.uid).snapshots();
          // currentStream3.forEach((field) {
          //   field.docs.asMap().forEach((index, data) {
          //     setState(() {
          //       addressList.add(field.docs[index]["course_info"]["course_addr"]);
          //       courseNameList.add(field.docs[index]["course_info"]["course_name"]);
          //       print("${field.docs[index]["course_info"]["course_addr"]} is pick");
          //     });
          //   });
          // });
        });
      });
    });
    currentStream3 = firestore.collection('Course').where("From", isEqualTo: this.uid).snapshots();
    currentStream3.forEach((field) {
      field.docs.asMap().forEach((index, data) {
        setState(() {
          addressList.add(field.docs[index]["course_info"]["course_addr"]);
          courseNameList.add(field.docs[index]["course_info"]["course_name"]);
          print("${field.docs[index]["course_info"]["course_addr"]} is pick");
        });
      });
    });
  }


  //itemList => pic , titleList => title
  List<String> itemList = [];
  List<String> titleList = [];
  List<int> likeList = [];

  List<String> addressList = []; //코스 시작주소 저장하는 리스트
  List<String> courseNameList = []; //코스 이름 저장하는 리스트

  final ScrollController _scrollController = ScrollController();
  var _controller = TextEditingController();
  SwiperController controller;
  Color myHexColor = Color(0xFFE3F2FD);
  Color myThemeColor = Color(0xFFBBDEFB);

  List choices = const[
    const Choice(
        space: '인하대 hidden places',
        like: '인천광역시 남구 용현1.4동 인하로 100',
        imglink:'https://image.edaily.co.kr/images/photo/files/NP/S/2018/06/PS18062101013.jpg' ,
        heart: 'lib/images/heart.jpg',
    ),
    const Choice(
        space: '부평 맛집 투어',
        like: '인천광역시 부평구 부평5동 201-31',
        imglink: 'http://tong.visitkorea.or.kr/cms/resource/60/1986160_image2_1.jpg',
        heart: 'lib/images/heart.jpg'
    )
  ];

  List choices1 = const[
    const Choice1(
        space: '해운대 앞 바다',
        like: '109',
        imglink: 'f'
    ),
    const Choice1(
        space: '강남어딘가',
        like: '1005',
        imglink: 'f'
    ),
    const Choice1(
        space: '일산 호수공원',
        like: '724',
        imglink: 'f'
    )
  ];
  final List<String> theme = ['데이트','먹방','힐링','오락','건강'];



  //실제위치 받아오는 함수.
  void currentlocatePosition() async {
    //Accuracy.bestForNavigation도 굳.
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position; //position에서 lat,lng를 받아온다.
  }

  void getCurrentSubLocality() async {
    final coordinated = geoCo.Coordinates(
        currentPosition.latitude, currentPosition.longitude);
    var address = await geoCo.Geocoder.local.findAddressesFromCoordinates(
        coordinated);
    var firstAddress = address.first;
    setState(() {
      myCurrentSubLocality = firstAddress.subLocality;
    });
  }
  // Future<List<String>> addImageToFirebase(List imageLinks) async {
  //   List<String> urlList= [];
  //   for(int i = 0; i< imageLinks.length; i++) {
  //     var ref = firestorage.ref().child('images/spot_images/${imageLinks[i]}');
  //     var v = await ref.getDownloadURL();
  //     urlList.add(v);
  //   }
  //   return urlList;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
          title:  Text('Blue Spot', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          iconTheme: new IconThemeData(color: Colors.grey),
      ),
      body: Container(
          child:SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(left:25, bottom: 16,top:10),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:<Widget>[
                            Text('#오늘의 Hot 스팟', style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ))
                          ]
                      )
                  ),
                  Container(
                    height: 360,
                    child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(left:16, right:6),
                          itemCount: markerId.length,
                          itemBuilder: (context,index){
                            return GestureDetector(
                              onTap: () {
                                print("$markerId is mark id");
                                Navigator.of(context).popUntil((route) => route.isFirst);
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>
                                    SpotPage2(uid: this.uid,loggeduser: this.loggeduser, marker_id: markerId[index],)));
                              },
                              child: Container(
                                margin: EdgeInsets.only(right:10),
                                height:199,
                                width:360,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  border: Border.all(width: 0.1),
                                ),

                                child: Stack(
                                    children:<Widget>[
                                      FutureBuilder(
                                        future: addImageToFirebase(itemList),
                                        builder: (context, snapshot) {

                                          if (snapshot.hasData == false || snapshot.data.length == 0) {
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
                                          else {
                                            return Positioned(
                                                left: 15,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    //padding
                                                    Container(
                                                      height: 15,
                                                    ),
                                                    Image.network(snapshot.data[index],
                                                      width: MediaQuery.of(context).size.width*0.80,
                                                      height: 250,
                                                      fit: BoxFit.fill,),
                                                    Padding(
                                                      padding: EdgeInsets.fromLTRB(2.0, 12.0, 16.0, 8.0),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        //mainAxisAlignment: MainAxisAlignment.end,
                                                        children:<Widget> [
                                                          Column(
                                                              children:[
                                                                Text(
                                                                  titleList[index],
                                                                  textAlign: TextAlign.start,
                                                                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                                                ),
                                                                Container(
                                                                  margin: EdgeInsets.only(right:35),
                                                                  child:Row(
                                                                    children: <Widget>[
                                                                      IconButton(
                                                                        icon: Icon(EvaIcons.heart , color: Colors.red,),
                                                                        iconSize: 25,
                                                                      ),
                                                                      Text(likeList[index].toString(),style: GoogleFonts.inter(
                                                                        fontSize:20,
                                                                        fontWeight: FontWeight.w400,),
                                                                      )
                                                                    ]
                                                                  )
                                                                )
                                                              ]
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    // Text(titleList[index],style: GoogleFonts.inter(
                                                    //   fontSize:22,
                                                    //   fontWeight: FontWeight.bold,
                                                    // )),

                                                  ],
                                                ),

                                            );
                                          }
                                        }
                                      ),
                                    ]
                                ),
                              ),
                            );
                          }),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top:60,right:160,),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:<Widget>[
                            Text('#나에게 맞는', style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                            Text('다른 사용자들의 코스는', style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                          ]
                      )

                  ),
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  //   height: MediaQuery.of(context).size.height * 0.12,
                  //
                  //   child: ListView.builder(
                  //       scrollDirection: Axis.horizontal,
                  //       itemCount: theme.length, itemBuilder: (context, index) {
                  //     return Container(
                  //       width: MediaQuery.of(context).size.width * 0.3,
                  //       child: Card(
                  //         elevation: 0,
                  //         color: myThemeColor,
                  //         child: InkWell(
                  //           onTap: (){
                  //             Navigator.pushNamed(context, '/clickCourseThemeSetting');
                  //           },
                  //         child: Container(
                  //           child: Center(child: Text(theme[index].toString(), style: TextStyle(color: Colors.black, fontSize: 17.0),)),
                  //         ),
                  //         )
                  //       ),
                  //     );
                  //   }),
                  // ),
                  ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      controller: _scrollController,
                      //padding: const EdgeInsets.all(20.0),
                      padding: EdgeInsets.only(top:3,right:20, left:20,bottom:20),
                      children: List.generate(addressList.length,(index){
                        return Center(
                          child: _ChoiceCard(choice: courseNameList[index],item:addressList[index]),
                        );
                      })
                  ),
                  Padding(
                      padding: EdgeInsets.only(top:40,right:160,bottom:4),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:<Widget>[
                            Text('#Blue Spot의', style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                            Text('추천 코스를 만나보세요', style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                          ]
                      )
                  ),
                  new Card(
                    child: new Column(
                      children: <Widget>[
                        //new Image.network('https://i.ytimg.com/vi/fq4N0hgOWzU/maxresdefault.jpg'),
                        Image.asset('lib/images/map1.png', width:380,height:380),
                        Padding(
                            padding: EdgeInsets.only(top:1,left:12,bottom:15),
                          child: new Row(
                            children: <Widget>[
                              new Padding(
                                padding: new EdgeInsets.all(7.0),
                                child: new Icon(Icons.thumb_up),
                              ),
                              new Padding(
                                  padding: new EdgeInsets.all(7.0),
                                child: new Text('내 코스로 등록',style: new TextStyle(fontSize: 18.0))
                              )
                            ]
                          )
                        )
                      ]
                    )
                  )
                ],

              )
          )

      ),
      drawer: new Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(loggeduser.photoURL.toString()),
                backgroundColor: Colors.white,
              ),

              otherAccountsPictures: <Widget>[
                new Container(
                  child: new IconButton(
                    icon : new Icon(Icons.camera_alt),
                    onPressed: (){
                      _showChoiceDialog(context);
                    },
                  )
                ),
                CircleAvatar(
                  backgroundImage: AssetImage('lib/images/star.jpg'),
                  backgroundColor: Colors.white,
                ),
              ],
              onDetailsPressed: (){
               // Navigator.pushNamed(context, '/ToMyPage');
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyPage(uid: this.uid,loggeduser: this.loggeduser,),
                    ));
                //인하 혹은 이메일을 눌러도 마이페이지로 이동 가능
              },

              accountName: new Container(
                  child: Text(loggeduser.displayName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black))),

              accountEmail: Text(loggeduser.email,style: TextStyle(color: Colors.black),),

              decoration: BoxDecoration(
                color: myHexColor,
              ),
            ),
            ListTile(
                leading: Icon(Icons.person,
                  color: Colors.grey[850],
                ),
                title: Text('My Page'),
                onTap:(){
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyPage(uid: this.uid,loggeduser: this.loggeduser,),
                      ));
                }
            ),
            ListTile(
                leading: Icon(Icons.location_on,
                  color: Colors.grey[850],
                ),
                title: Text('지도로 가기'),
                onTap:() async{
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MakeCourse(uid: this.uid, loggeduser: this.loggeduser,)));
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MakeCourse(uid: this.uid,loggeduser: this.loggeduser,)));
                }
            ),
            // AR은 아직 고려사항이 아님.
            // ListTile(
            //     leading: Icon(Icons.my_location,
            //       color: Colors.grey[850],
            //     ),
            //     title: Text('AR로 가기'),
            //     onTap:(){
            //       Navigator.of(context).pop();
            //       Navigator.pushNamed(context,'/errorPage');
            //     }
            // ),
            ListTile(
                leading: Icon(Icons.apps,
                  color: Colors.grey[850],
                ),
                title: Text('코스 관리하기'),
                onTap:(){
                  Navigator.of(context).popUntil((route) => route.isFirst);

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ManageCoursePage(uid: this.uid,loggeduser: this.loggeduser,),
                      ));

                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ManageCoursePage(uid: this.uid,loggeduser: this.loggeduser,)));

                }
            ),
            ListTile(
                leading: Icon(Icons.settings,
                  color: Colors.grey[850],
                ),
                title: Text('설정'),
                onTap:(){
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context,'/toSettingPage');
                }
            ),
            ListTile(
                leading: Icon(Icons.lock,
                  color: Colors.grey[850],
                ),
                title: Text('로그아웃'),
                onTap:() => _popupDialog(context)
            ),
          ],
        ),

      ),
    );
  }


  void _popupDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('로그아웃 하시겠습니까?',),
            //content: Text('Alert Dialog Body Goes Here  ..'),
            actions: <Widget>[
              FlatButton(/*
                  onPressed: (){
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context,'/AfterSplash');
                  },*/
                  onPressed: () => signOutUser().whenComplete(() async{
                    Navigator.of(context).pop();
                   Navigator.of(context).pushNamed(('/AfterSplash'));
                  }),
                  child: Text('YES')),
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('CANCEL')),
            ],
          );
        });
  }

  //여기서부터 우리 drawer에 있는 배경화면 변경하는거.
  File imageFile;

  Future <void> _showChoiceDialog(BuildContext context) {
    return showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Make a choice"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text("Gallery"),
                onTap: () {
                  _openGallery(context);
                },
              ),
              Padding(
                  padding: EdgeInsets.all(8.0)
              ),
              GestureDetector(
                child: Text("Camera"),
                onTap: () {
                  _openCamera(context);
                },
              )
            ],
          ),
        ),
      );
    });
  }

  //갤러리 여는거
  _openGallery(BuildContext context) async {
    var pic = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = pic;
    });
    Navigator.of(context).pop();
  }

  //카메라 여는거.
  _openCamera(BuildContext context) async {
    var pic = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = pic;
    });
    Navigator.of(context).pop();
  }

}

class Choice{
  final String space;
  final String like;
  final String imglink;
  final String heart;
  const Choice({this.space,this.like,this.imglink,this.heart});
}
class Choice1{
  final String space;
  final String like;
  final String imglink;
  const Choice1({this.space,this.like,this.imglink});
}
class ChoiceCard1 extends StatelessWidget{
  const ChoiceCard1(
      {Key key, this.choice, this.onTap,@required this.item,
        this.selected:false}) : super(key:key);
  final Choice1 choice;
  final VoidCallback onTap;
  final Choice1 item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white,
        child: Column(
          children:<Widget>[
            new Container(
                padding:const EdgeInsets.all(8.0),
                child: Image.network('https://images.unsplash.com/photo-1517694712202-14dd9538aa97?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60')
            ),
            new Container(
              padding: const EdgeInsets.all(10.0),
              child:Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:<Widget>[
                    Text(choice.space, style: GoogleFonts.inter(
                      fontSize:22,
                      fontWeight: FontWeight.bold,
                    ),),
                    Row(
                        children:[

                          IconButton(
                            icon: Icon(EvaIcons.heart , color: Colors.red,),
                            iconSize: 20,
                          ),
                          Text(choice.like,style: GoogleFonts.inter(
                            fontSize:18,
                            fontWeight: FontWeight.w500,
                          ), )
                        ]
                    )
                  ]
              ),
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        )
    );
  }
}
class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice, this.onTap, @required this.item,
    this.selected: false}) : super(key: key);
  final Choice choice;
  final VoidCallback onTap;
  final Choice item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white,
        child: Column(
          children: [
            new Container(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(choice.imglink)
            ),
            new Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(choice.space, style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),),
                    Row(
                        children: [
                          Text(choice.like, style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),)
                        ]
                    )
                  ]
              ),
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        )
    );
  }
}
class _ChoiceCard extends StatelessWidget {
  const _ChoiceCard({Key key, this.choice, this.onTap, @required this.item,
    this.selected: false}) : super(key: key);
  final String choice; //title
  final VoidCallback onTap;
  final String item; //address
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white,
        child: Column(
          children: [
            new Container(
                padding: const EdgeInsets.all(8.0),
                child: Image.network('https://image.edaily.co.kr/images/photo/files/NP/S/2018/06/PS18062101013.jpg')
            ),
            new Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(choice, style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),),
                    Row(
                        children: [
                          Text(item, style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),)
                        ]
                    )
                  ]
              ),
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        )
    );
  }
}
class UserInfo {
  final String user_id;
  final String user_password;
  final String user_name;
  final String user_picture;
  final List<String> theme_id;
  final List<String> my_course;
  final List<String> my_spot;
  final List<int> my_position;

  UserInfo({this.user_id, this.user_password, this.user_name, this.user_picture,
    this.theme_id, this.my_course, this.my_spot, this.my_position});
}
