import 'package:flutter/material.dart';
import 'dart:core';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:bluespot/pages/myPage.dart';
import 'package:bluespot/pages/errorPage.dart';
import 'package:bluespot/pages/spotPage.dart';
import 'package:bluespot/pages/manageCoursePage.dart';

import 'package:http/http.dart' as http;

class UserInfo {
  final String user_id;
  final String user_password;
  final String user_name;
  final String user_picture;
  final List<String> theme_id;
  final List<String> my_course;
  final List<String> my_spot;
  final List<int> my_position;

  UserInfo({this.user_id, this.user_password, this.user_name,this.user_picture,
    this.theme_id,this.my_course,this.my_spot,this.my_position});

  // factory UserInfo.fromJson(Map<String, dynamic> json) {
  //   return UserInfo(
  //     user_id: json['user_id'] as String,
  //     user_password: json['user_password'] as String,
  //     user_name: json['user_name'] as String,
  //     user_picture: json['user_picture'] as String,
  //     theme_id: json['theme_id'] as List<String>,
  //     my_course: json['my_course'] as List<String>,
  //     my_spot: json['my_spot'] as List<String>,
  //     my_position: json['my_position'] as List<int>
  //   );
  }

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}



class _MainPageState extends State<MainPage> {

  // Future<http.Response> fetchPhotos(http.Client client) async {
  //   return client.get('url');
  // }
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
          actions:[
            Icon(Icons.more_vert,),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 8)
            ),
          ]
      ),
      body: Container(
          child:SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
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
                  Padding(
                      padding: EdgeInsets.only(left:25, bottom: 16),
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
                    height: 320,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/clickSpot');
                      },
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(left:16, right:6),
                          itemCount: 3,
                          itemBuilder: (context,index){
                            return Container(
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
                                    Positioned(
                                        left:15,
                                        child:Image.network('https://i2.wp.com/blog.allstay.com/wp-content/uploads/2019/07/2_122623_02-1.jpg?w=1024&ssl=1',
                                          width: 330,
                                          height:250,)
                                    ),
                                    Positioned(
                                      left:25,
                                      top:242,
                                      child:Text('해운대 앞 바다',style: GoogleFonts.inter(
                                        fontSize:22,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                    ),
                                    Positioned(
                                        left:15,
                                        top:270,
                                        child: Row(
                                            children:[

                                              IconButton(
                                                icon: Icon(EvaIcons.heart , color: Colors.red,),
                                                iconSize: 20,
                                              ),
                                              Text('109',style: GoogleFonts.inter(
                                                fontSize:18,
                                                fontWeight: FontWeight.w500,
                                              ), )
                                            ]
                                        )
                                    )
                                  ]
                              ),
                            );
                          }),
                    ),
                  ),
                  /*
                  new ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      controller: _scrollController,
                      padding: const EdgeInsets.all(20.0),
                      children: List.generate(choices1.length,(index){
                        return Center(
                          child: ChoiceCard1(choice: choices1[index],item:choices1[index]),
                        );
                      })
                  ),*/
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    height: MediaQuery.of(context).size.height * 0.12,

                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: theme.length, itemBuilder: (context, index) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Card(
                          elevation: 0,
                          color: myThemeColor,
                          child: InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, '/clickCourseThemeSetting');
                            },
                          child: Container(
                            child: Center(child: Text(theme[index].toString(), style: TextStyle(color: Colors.black, fontSize: 17.0),)),
                          ),
                          )
                        ),
                      );
                    }),
                  ),
                  new ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      controller: _scrollController,
                      //padding: const EdgeInsets.all(20.0),
                      padding: EdgeInsets.only(top:3,right:20, left:20,bottom:20),
                      children: List.generate(choices.length,(index){
                        return Center(
                          child: ChoiceCard(choice: choices[index],item:choices[index]),
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
                        new Padding(
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
            /*
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.grey,
              )

            ),*/
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('lib/images/b.jpg'),
                backgroundColor: Colors.white,
              ),
              otherAccountsPictures: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage('lib/images/star.jpg'),
                  backgroundColor: Colors.white,
                ),
              ],
              onDetailsPressed: (){
                //인하 혹은 이메일을 눌러도 마이페이지로 이동 가능
              },
              accountName: new Container(
                  child: Text(
                      '인하',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black)
                  )
              ),
              accountEmail: Text('12172919@inha.edu',style: TextStyle(color: Colors.black),),

              decoration: BoxDecoration(
                color: myHexColor,
              ),
            ),
            /*
            Divider(
                color: Colors.grey,
            ),*/
            ListTile(
                leading: Icon(Icons.person,
                  color: Colors.grey[850],
                ),
                title: Text('My Page'),
                onTap:(){
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context,'/ToMyPage');
                }
            ),
            ListTile(
                leading: Icon(Icons.location_on,
                  color: Colors.grey[850],
                ),
                title: Text('지도로 가기'),
                onTap:(){
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => ErrorPage()));
                }
            ),
            ListTile(
                leading: Icon(Icons.my_location,
                  color: Colors.grey[850],
                ),
                title: Text('AR로 가기'),
                onTap:(){
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => ManageCoursePage()));
                }
            ),
            ListTile(
                leading: Icon(Icons.settings,
                  color: Colors.grey[850],
                ),
                title: Text('설정'),
                onTap:(){
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => ErrorPage()));
                }
            ),
            ListTile(
                leading: Icon(Icons.lock,
                  color: Colors.grey[850],
                ),
                title: Text('로그아웃'),
                onTap:(){
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => ErrorPage()));
                }
            ),
          ],
        ),

      ),

    );
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
class ChoiceCard extends StatelessWidget{
  const ChoiceCard(
      {Key key, this.choice, this.onTap,@required this.item,
        this.selected:false}) : super(key:key);
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
          children:[
            new Container(
                padding:const EdgeInsets.all(8.0),
                child: Image.network(choice.imglink)
            ),
            new Container(
              padding: const EdgeInsets.all(10.0),
              child:Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Text(choice.space, style: GoogleFonts.inter(
                      fontSize:22,
                      fontWeight: FontWeight.bold,
                    ),),
                    Row(
                        children:[
                          /*
                    IconButton(
                      icon: Icon(EvaIcons.heart , color: Colors.red,),
                      iconSize: 20,
                    ),*/
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