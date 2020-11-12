import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:material_segmented_control/material_segmented_control.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {

  int _currentSelection = 0;

  Map<int, Widget> _children = {
    0: Text('     MINE     '),
    1: Text('LIKE'),
    2: Text('VISIT'),
  };

  final List<String> myImages = [
    "lib/images/b.jpg",
    "lib/images/b.jpg",
    "lib/images/b.jpg",
    "lib/images/b.jpg",
    "lib/images/b.jpg"
  ];

  final List<String> likeImages = [
    "lib/images/h.jpg",
    "lib/images/h.jpg",
    "lib/images/h.jpg",
    "lib/images/h.jpg",
    "lib/images/h.jpg"
  ];

  final List<String> visitImages = [
    "lib/images/60.jpg",
    "lib/images/60.jpg",
    "lib/images/60.jpg",
    "lib/images/60.jpg",
    "lib/images/60.jpg"
  ];

  @override
  Widget build(BuildContext context) {

    final List<List<String>> imageList = [myImages, likeImages, visitImages];


    return Scaffold(
      appBar: AppBar(
          title: Text('마이페이지', style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold)),
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 2,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 120.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/images/b.jpg'),
                    fit: BoxFit.contain,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                height: 122,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "비룡",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Arial",
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: EdgeInsets.only(top: 6),
                        child: Text(
                          "12172919@inha,edu",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Arial",
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      "안녕하세요!  전국 각지의 hot한 spot및 코스들을 \n다 방문하고 싶습니다.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Arial",
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 1.71429,
                      ),
                    ),
                  ],
                ),
              ),
              //Spacer(),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 248,
                  height: 44,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        width: 81,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                margin: EdgeInsets.only(left: 19),
                                child: Text(
                                  "140",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Arial",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "내가 올린 SPOT",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Arial",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: 2,
                          height: 24,
                          margin: EdgeInsets.only(left: 36, top: 13),
                          decoration: BoxDecoration(
                            color: Colors.black,
                          ),
                          child: Container(),
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: 103,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                margin: EdgeInsets.only(right: 40),
                                child: Text(
                                  "140",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Arial",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "내가 좋아하는 SPOT",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Arial",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 20,
              ),

              MaterialSegmentedControl(
                children: _children,
                selectionIndex: _currentSelection,
                borderColor: Colors.black,
                verticalOffset: 08.0,
                selectedColor: Colors.redAccent,
                unselectedColor: Colors.white,
                borderRadius: 32.0,
                onSegmentChosen: (index) {
                  setState(() {
                    _currentSelection = index;
                  });
                },
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 20,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/2,

                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Column(
                          children: [
                            Image.asset(imageList[_currentSelection][index],
                            width: 300,
                            height: 100,),
                            Text("비룡이 얼굴짱커"),
                          ],
                        ),
                      );
                    },
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }

}
