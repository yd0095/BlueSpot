import 'package:flutter/material.dart';
import 'dart:core';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:bluespot/pages/myPage.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ScrollController _scrollController = ScrollController();
  var _controller = TextEditingController();
  SwiperController controller;
  Color myHexColor = Color(0xFFE3F2FD);
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
                            Text('#오늘의 Pick', style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ))
                          ]
                      )
                  ),

                  Container(
                    height: 320,
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
                      padding: EdgeInsets.only(top:30, left:25),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:<Widget>[
                            Text('#코스', style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ))
                          ]
                      )
                  ),

                  new ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      controller: _scrollController,
                      padding: const EdgeInsets.all(20.0),
                      children: List.generate(choices.length,(index){
                        return Center(
                          child: ChoiceCard(choice: choices[index],item:choices[index]),
                        );
                      })
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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MyPage()));
                }
            ),
            ListTile(
                leading: Icon(Icons.location_on,
                  color: Colors.grey[850],
                ),
                title: Text('지도로 가기'),
                onTap:(){
                }
            ),
            ListTile(
                leading: Icon(Icons.my_location,
                  color: Colors.grey[850],
                ),
                title: Text('코스 관리하기'),
                onTap:(){
                }
            ),
            ListTile(
                leading: Icon(Icons.settings,
                  color: Colors.grey[850],
                ),
                title: Text('설정'),
                onTap:(){
                }
            ),
            ListTile(
                leading: Icon(Icons.lock,
                  color: Colors.grey[850],
                ),
                title: Text('로그아웃'),
                onTap:(){
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