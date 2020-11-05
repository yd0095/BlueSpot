import 'package:flutter/material.dart';
import 'package:bluespot/pages/mainPage.dart';

class SpotPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => MainPage()));
            }
          ),
          title:  Text('스팟', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 94,
                height: 34,
                margin: EdgeInsets.only(left: 105, top: 63),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "비룡",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Arial",
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      "12171929@inha.edu",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Arial",
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 311,
              height: 232,
              margin: EdgeInsets.only(top: 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 176,
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Container(),
                  ),
                  Spacer(),
                  Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Container(),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 81,
                height: 36,
                margin: EdgeInsets.only(left: 46, top: 23),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "해운대 앞 바다",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Arial",
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(right: 6),
                      child: Text(
                        "부산 해운대구 우동",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Arial",
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 296,
                margin: EdgeInsets.only(top: 30, right: 33),
                child: Text(
                  "부산 해운대구 중동 ·좌동 ·우동에 걸쳐 있는 해수욕장. 백사장 길이 1.8km, 너비 35~50m, 면적 7만 2000㎡이다. 수심이 얕고 조수의 변화도 심하지 않아 해수욕장으로서의 조건이 좋다. ",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Arial",
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: 70, bottom: 19),
                child: Text(
                  "120",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Arial",
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            Container(
              width: 308,
              height: 127,
              margin: EdgeInsets.only(bottom: 16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Expanded(
                    //bottom: 43,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 44,
                          margin: EdgeInsets.only(left: 30, right: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  width: 17,
                                  height: 17,
                                  margin: EdgeInsets.only(top: 15),
                                  child: Image.asset(
                                    "assets/images/--216--1.png",
                                    fit: BoxFit.none,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    height: 44,
                                    margin: EdgeInsets.only(left: 22),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          height: 20,
                                          margin: EdgeInsets.only(left: 3, right: 8),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Container(
                                                  margin: EdgeInsets.only(top: 3),
                                                  child: Text(
                                                    "린다G",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: "Arial",
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Spacer(),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "1h",
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "Arial",
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            width: 224,
                                            margin: EdgeInsets.only(top: 7),
                                            child: Text(
                                              " 저도 코로나 끝나면 가보고 싶어요!",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: "Arial",
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Opacity(
                          opacity: 0.5,
                          child: Container(
                            height: 1,
                            margin: EdgeInsets.only(top: 18),
                            decoration: BoxDecoration(
                              color: Colors.black,
                            ),
                            child: Container(),
                          ),
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 72),
                            child: Text(
                              "유두래곤",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Arial",
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 42,
                          margin: EdgeInsets.only(left: 30, right: 11),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  width: 17,
                                  height: 17,
                                  margin: EdgeInsets.only(top: 13),
                                  child: Image.asset(
                                    "assets/images/--216--1.png",
                                    fit: BoxFit.none,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  width: 224,
                                  height: 42,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          margin: EdgeInsets.only(right: 12),
                                          child: Text(
                                            "8h",
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Arial",
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          width: 224,
                                          margin: EdgeInsets.only(top: 8),
                                          child: Text(
                                            "바다 어땠나요?!",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Arial",
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
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
                        Opacity(
                          opacity: 0.5,
                          child: Container(
                            height: 1,
                            decoration: BoxDecoration(
                              color: Colors.black,
                            ),
                            child: Container(),
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
    );
  }
}