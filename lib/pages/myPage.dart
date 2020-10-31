import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title:  Text('마이페이지', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
        child: ListView(
          children: [
            Container(
              width: 326,
              height: 200,
              margin: EdgeInsets.only(top: 103),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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
                  Spacer(),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 248,
                      height: 44,
                      margin: EdgeInsets.only(right: 33),
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
                ],
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 320,
                height: 468,
                margin: EdgeInsets.only(left: 28),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      bottom: 0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 152,
                            height: 468,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      Container(),
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        right: 0,
                                        child: Container(
                                          height: 186,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.5),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: Offset(0,3),
                                              ),
                                            ],
                                          ),
                                          child: Container(),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        right: 0,
                                        bottom: 0,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Container(
                                              height: 120,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.5),
                                                    spreadRadius: 5,
                                                    blurRadius: 7,
                                                    offset: Offset(0,3),
                                                  ),
                                                ],
                                              ),
                                              child: Container(),
                                            ),
                                            Spacer(),
                                            Container(
                                              height: 120,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.5),
                                                    spreadRadius: 5,
                                                    blurRadius: 7,
                                                    offset: Offset(0,3),
                                                  ),
                                                ],
                                              ),
                                              child: Container(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  top: 206,
                                  child: Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      Container(),
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        right: 0,
                                        child: Container(
                                          height: 186,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.5),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: Offset(0,3),
                                              ),
                                            ],
                                          ),
                                          child: Container(),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        right: 0,
                                        bottom: 0,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Container(
                                              height: 120,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.5),
                                                    spreadRadius: 5,
                                                    blurRadius: 7,
                                                    offset: Offset(0,3),
                                                  ),
                                                ],
                                              ),
                                              child: Container(),
                                            ),
                                            Spacer(),
                                            Container(
                                              height: 120,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.5),
                                                    spreadRadius: 5,
                                                    blurRadius: 7,
                                                    offset: Offset(0,3),
                                                  ),
                                                ],
                                              ),
                                              child: Container(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: 152,
                            height: 468,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        right: 0,
                                        child: Container(
                                          height: 186,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.5),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: Offset(0,3),
                                              ),
                                            ],
                                          ),
                                          child: Container(),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        right: 0,
                                        bottom: 0,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Container(
                                              height: 120,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.5),
                                                    spreadRadius: 5,
                                                    blurRadius: 7,
                                                    offset: Offset(0,3),
                                                  ),
                                                ],
                                              ),
                                              child: Container(),
                                            ),
                                            Spacer(),
                                            Container(
                                              height: 120,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.5),
                                                    spreadRadius: 5,
                                                    blurRadius: 7,
                                                    offset: Offset(0,3),
                                                  ),
                                                ],
                                              ),
                                              child: Container(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 206,
                                  right: 0,
                                  child: Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        right: 0,
                                        child: Container(
                                          height: 186,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.5),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: Offset(0,3),
                                              ),
                                            ],
                                          ),
                                          child: Container(),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        right: 0,
                                        bottom: 0,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Container(
                                              height: 120,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.5),
                                                    spreadRadius: 5,
                                                    blurRadius: 7,
                                                    offset: Offset(0,3),
                                                  ),
                                                ],
                                              ),
                                              child: Container(),
                                            ),
                                            Spacer(),
                                            Container(
                                              height: 120,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.5),
                                                    spreadRadius: 5,
                                                    blurRadius: 7,
                                                    offset: Offset(0,3),
                                                  ),
                                                ],
                                              ),
                                              child: Container(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 91,
                      bottom: 88,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: EdgeInsets.only(left: 1, bottom: 41),
                              child: Text(
                                "SPOT 등록하기",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Arial",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "코스 관리하기",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Arial",
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
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
          ],
        ),
      ),
    );
  }
}