import 'package:flutter/material.dart';

class ManageCoursePage extends StatefulWidget {
  @override
  _ManageCoursePageState createState() => _ManageCoursePageState();
}

class _ManageCoursePageState extends State<ManageCoursePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
          title:  Text('코스관리하기', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 65,
              margin: EdgeInsets.only(left: 16, top: 32, right: 16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 65,
                      decoration: BoxDecoration(
                        color: Color(0xFFF1F9FF),
                        border: Border.all(
                          color: Colors.black,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0)
                        )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 65),
                            child: Text(
                              "코스 생성하기",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Arial",
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 21,
                    left: 20,
                    child: Icon(Icons.add_location_alt_rounded,
                      color: Colors.grey[850],
                    ),
                  ),
                  Positioned(
                    top: 21,
                    right: 27,
                    child: Icon(Icons.arrow_forward_outlined,
                      color: Colors.grey[850],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 65,
              margin: EdgeInsets.only(left: 16, top: 26, right: 16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 65,
                      decoration: BoxDecoration(
                          color: Color(0xFFF1F9FF),
                          border: Border.all(
                            color: Colors.black,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(10.0)
                          )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 65),
                            child: Text(
                              "관심코스 테마 설정",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Arial",
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 21,
                    left: 20,
                    child: Icon(Icons.apps_rounded,
                      color: Colors.grey[850],
                    ),
                  ),
                  Positioned(
                    top: 21,
                    right: 27,
                    child: Icon(Icons.arrow_forward_outlined,
                      color: Colors.grey[850],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 65,
              margin: EdgeInsets.only(left: 16, top: 29, right: 16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 65,
                      decoration: BoxDecoration(
                          color: Color(0xFFF1F9FF),
                          border: Border.all(
                            color: Colors.black,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(10.0)
                          )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 65),
                            child: Text(
                              "내가 등록한 코스 보기",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Arial",
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 21,
                    left: 20,
                    child: Icon(Icons.zoom_in_rounded,
                      color: Colors.grey[850],
                    ),
                  ),
                  Positioned(
                    top: 21,
                    right: 27,
                    child: Icon(Icons.arrow_forward_outlined,
                      color: Colors.grey[850],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 65,
              margin: EdgeInsets.only(left: 16, top: 31, right: 16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 65,
                      decoration: BoxDecoration(
                          color: Color(0xFFF1F9FF),
                          border: Border.all(
                            color: Colors.black,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(10.0)
                          )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 65),
                            child: Text(
                              "자동 코스 추천",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Arial",
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 21,
                    left: 20,
                    child: Icon(Icons.map,
                      color: Colors.grey[850],
                    ),
                  ),
                  Positioned(
                    top: 21,
                    right: 27,
                    child: Icon(Icons.arrow_forward_outlined,
                      color: Colors.grey[850],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
