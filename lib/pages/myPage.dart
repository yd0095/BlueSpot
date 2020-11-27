import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:easy_permission_validator/easy_permission_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import  'package:camera_camera/camera_camera.dart';
import 'package:bluespot/pages/googleAuthentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bluespot/pages/mainPage.dart';
import 'package:bluespot/pages/mapPage.dart';
import 'package:http/http.dart' as http;


class selectedImage{
  File myImage;
}
class MyPage extends StatefulWidget {

  //uid => Auth, loggeduser => google login information
  final String uid;
  final User loggeduser;

  MyPage({Key key, @required this.uid, this.loggeduser,}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState(uid, loggeduser);
}
class _MyPageState extends State<MyPage> {

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage firestorage = FirebaseStorage.instance;
  Stream<QuerySnapshot> currentStream;

  @override
  void initState() {
    super.initState();

    currentStream = firestore.collection('Spot').where("From", isEqualTo: this.uid).snapshots();
    currentStream.forEach((field) {
      field.docs.asMap().forEach((index, data) {
        setState(() {
          itemList.add(field.docs[index]["Content"]["Content_picture"]);
          titleList.add(field.docs[index]["Content"]["Content_Title"]);
          print(itemList);
        });
      });
    });
  }

  // Future<void> downloadFile() async {
  //
  //   var ref = firestorage.ref().child('images/spot_images/${imageLinks[i]}');
  //   final String url = await ref.getDownloadURL();
  //   final http.Response downloadData = await http.get(url);
  //   final Directory systemTempDir = Directory.systemTemp;
  //   final File tempFile = File('${systemTempDir.path}/tmp.jpg');
  //   if (tempFile.existsSync()) {
  //     await tempFile.delete();
  //   }
  //   await tempFile.create();
  //   final dynamic task = ref.writeToFile(tempFile);
  //   final int byteCount = (await task.future).totalByteCount;
  //   var bodyBytes = downloadData.bodyBytes;
  //   final String name = await ref.getName();
  //   final String path = await ref.getPath();
  //   print(
  //     'Success!\nDownloaded $name \nUrl: $url'
  //         '\npath: $path \nBytes Count :: $byteCount',
  //   );
  //   _scaffoldKey.currentState.showSnackBar(
  //     SnackBar(
  //       backgroundColor: Colors.white,
  //       content: Image.memory(
  //         bodyBytes,
  //         fit: BoxFit.fill,
  //       ),
  //     ),
  //   );
  // }


  // Future<List<String>> addImageToFirebase() async {
  //   List<String> url_list;
  //
  //   for (int i = 0; i< itemList.length; i++) {
  //     var ref = firestorage.ref().child('images/spot_images/${itemList[i]}');
  //     url_list.add(await ref.getDownloadURL());
  //     print("$url_list is list");
  //   }
  //
  //   return url_list;
  // }


  //여기에 큰 문제가 있음 리스트로 안넘어감.... 하나하나씩은 넘길수있는데 방안이 필요함..
  Future<List<String>> addImageToFirebase(List imageLinks) async {
    List<String> urlList= [];
    for(int i = 0; i< imageLinks.length; i++) {
      var ref = firestorage.ref().child('images/spot_images/${imageLinks[i]}');
      var v = await ref.getDownloadURL();
      urlList.add(v);
    }
    return urlList;
  }
  

  List<String> itemList = [];
  List<String> titleList = [];

  //uid => Auth, loggeduser => google login information
  final String uid;
  final User loggeduser;

  _MyPageState(this.uid, this.loggeduser);

  Future<File> imageFile;
  int _currentSelection = 0;

  //선택분기
  Map<int, Widget> _children = {
    0: Text('     MINE     '),
    1: Text('LIKE'),
    2: Text('VISIT'),
  };

  Future<File> _openGallary() async{
    File _image;
    final picker = ImagePicker();

    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    print('PickedFile: ${pickedFile.toString()}');

    setState(() {
      _image = File(pickedFile.path);
    });
    if (_image != null) {
      Navigator.pushReplacementNamed(context,
          '/toSpotMakePage',
          arguments: <String, File>{
            'photo' : _image
          }
      );
      return _image;
    }
    return null;
  }

  Future<File> _openCamera() async{
    File _image;
    final picker = ImagePicker();

    final pickedFile = await picker.getImage(source: ImageSource.camera);
    print('PickedFile: ${pickedFile.toString()}');

    setState(() {
      _image = File(pickedFile.path);
    });
    if (_image != null) {
      Navigator.pushReplacementNamed(context,
          '/toSpotMakePage',
          arguments: <String, File>{
            'photo' : _image
          }
      );
      return _image;
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>
                  MainPage(uid: this.uid, loggeduser: this.loggeduser,)));
            }
          ),
          title: Text('마이페이지', style: TextStyle(
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 2,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              //프로필사진
              Container(
                width: MediaQuery.of(context).size.width,
                height: 120.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(loggeduser.photoURL.toString()),
                    fit: BoxFit.contain,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              //프로필이름
              Container(
                height: 122,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        loggeduser.displayName,
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
                          loggeduser.email,
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
              // 내가올린SPOT / 내가좋아하는SPOT
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
              //패딩
              Container(
                width: MediaQuery.of(context).size.width,
                height: 20,
              ),
              //Mine Like Visit 선택박스 구성
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
              //패딩
              Container(
                width: MediaQuery.of(context).size.width,
                height: 20,
              ),
              //GridView
              FutureBuilder(
                future: addImageToFirebase(itemList),
                builder: (context, snapshot) {
                  return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height/2,
                          child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: itemList.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (BuildContext context, int index) {
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
                                //이렇게 따로받아오면 무조건 에러남 주의!!
                                //List<String> 자체가 Future로 받아와져서 파싱이 안돼있음 주의!!
                               //List<String> list = snapshot.data.toList(); xxxx
                                return Card(
                                  child: Column(
                                    children: [
                                      AspectRatio(aspectRatio:18.0 / 13.0,
                                      child: Image.network(snapshot.data[index],
                                        fit: BoxFit.fill,),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              titleList[index],
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                      //무조건 이렇게
                                    ],
                                  ),
                                );
                              }
                            },
                          )
                  );
                }
              ),
              Container(
                  width: 250,
                  height: 45,
                  margin: EdgeInsets.only(left: 16, top: 26, right: 16),
                  child: GestureDetector(
                    onTap: ()=> _popupDialog(context),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                            left: 0,
                            top: 0,
                            right: 0,
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: Color(0xFF2699FB),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                              child: GestureDetector(

                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 70),
                                      child: Text(
                                        "스팟 등록하기",
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
                              )

                            )),
                        Positioned(
                          top: 11,
                          right: 14,
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
              ),
              Container(
                  width: 250,
                  height: 45,
                  margin: EdgeInsets.only(left: 16, top: 13, right: 16),
                  child: GestureDetector(
                    onTap: () {
                    Navigator.pushNamed(context, '/manageCoursePage');
                    //Navigator.pushNamed(context, '/toSpotMakePage');
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
                                      "코스 관리하기",
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
                      ],
                    ),
                  )
              ),
              Container(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
  void _popupDialog(BuildContext context) async {
    Future<File> photo;
    /*
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('로그아웃 하시겠습니까?',),
            //content: Text('Alert Dialog Body Goes Here  ..'),
            actions: <Widget>[
              FlatButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context,'/AfterSplash');
                  },
                  child: Text('YES')),
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('CANCEL')),
            ],
          );
        });*/
    Alert(
      context: context,
      //type: AlertType.error,
      title: "스팟 사진 등록을 위해",
      desc: "어디로 이동하시겠습니까?",
      buttons: [
        DialogButton(
          child: Text(
            "카메라",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            _openCamera();

          },
          width: 120,
        ),DialogButton(
          child: Text(
            "갤러리",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            _openGallary();
          },
          width: 120,
        )
      ],
    ).show();
  }

}
