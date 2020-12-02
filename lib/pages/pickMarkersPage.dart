//import 'package:bluespot/pages/spotMakePage.dart';
import 'package:bluespot/pages/spotMakePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart' as geoCo;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:permission/permission.dart';
import 'dart:async';
import 'package:bluespot/pages/mainPage.dart';
import 'package:kopo/kopo.dart';
import 'package:bluespot/pages/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bluespot/pages/spotPage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';


// 중요! GCP 환경설정에서 direction api, maps sdk for android를 허용해야한다.
// 중요! direction을 이용하기전에 해당 기기의 위치를 사용하는 것에 대해서 권한을 받아야 한다.
//  -> location이 enabled되어 있는지 확인을 해야하고 유저에게 해당 기기의 현재 위치 사용 권한을 허락 받아야 한다.


class PickPage extends StatefulWidget {
  final String uid;
  final User loggeduser;
  PickPage({Key key, @required this.uid, this.loggeduser}) : super(key: key);

  @override
  _PickPageState createState() => _PickPageState(uid,loggeduser);
}

class _PickPageState extends State<PickPage> {

  final String uid;
  final User loggeduser;

  _PickPageState(this.uid, this.loggeduser); //현재위치

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot> currentStream;

  @override
  void initState() {
    // getMarkerData();
    _c = new TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCurrentLocation();
      getMarkerData();
      getCurrentSubLocality();
    });
    super.initState();
  }

  var mid;
  var sendMid;
  String addressJSON = '';
  GoogleMapController googleMapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Position position;
  String addressLocation;
  String country;

  var myCurrentSubLocality;

  String addr; //spotMakePage로 넘겨줄 스팟의 전체 주소(인천광역시 미추홀구 용현동...)
  TextEditingController _c;


  //여기서부터 내실시간 위치.
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  Position currentPosition; //내현재위치
  var geoLocator = Geolocator();


  //실제위치 받아오는 함수.
  void currentlocatePosition() async {
    //Accuracy.bestForNavigation도 굳.
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position; //position에서 lat,lng를 받아온다.

    //객체 생성해서 고도위도 넣음.
    LatLng latPosition = LatLng(position.latitude, position.longitude);

    //카메라 이동하기 위해선 현재 위치를 알아야하니까. 현재위치 알아내서 현재위치로 카메라 업데이트.
    CameraPosition cameraPosition = new CameraPosition(
        target: latPosition, zoom: 14.0);
    googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition));
  }

  List<String> threeMarkers=[];
  LatLng firstMarker;

  //init amrker, getMarker가 retrieve function. -> 실행안댐.
  //처음 실행하면 마커를 불러오기위해서 초기화하는 함수.
  void initMarker(specify, specifyId) async {
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
        markerId: markerId,
        position:
        // LatLng(specify['location'].latitude, specify['location'].longitude),
        LatLng(specify['lat, long'][0], specify['lat, long'][1]),
        onTap: (){
          if(threeMarkers.length < 3) {
            threeMarkers.add(specify['markerId']);
            if(threeMarkers.length == 1) {
              firstMarker = LatLng(specify['lat, long'][0], specify['lat, long'][1]);
            }
          }
          else{
            _popupDialog2(context);
          }
        }
    );
    setState(() {
      this.mid = markerId;
      markers[markerId] = marker;
    });
  }

  getMarkerData() async {
    //원래는 현재위치 받아야함 ->핸드폰에서 myCurrentSubLocality를 getCurrentSubLocality를 통해 받을거임
    var myCurrentSubLocality = "Incheon";
    await FirebaseFirestore.instance.collectionGroup(myCurrentSubLocality)
        .get()
        .then((myMockDoc) {
      for (int i = 0; i < myMockDoc.docs.length; i++) {
        initMarker(myMockDoc.docs[i].data(), myMockDoc.docs[i].id);
      }
    });
  }

  void getMarkers(double lat, double long,) {
    MarkerId markerId = MarkerId(lat.toString() + long.toString());
    mid = markerId;
    Marker _marker = Marker(
      markerId: markerId,
      position: LatLng(lat, long),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
      //infoWindow: InfoWindow(snippet: addressLocation)
      infoWindow: InfoWindow(title: "input", snippet: "data"),
    );
    setState(() {
      markers[markerId] = _marker;
      print(markerId); //ㄷㅂㄱ
      //print(markerId.toString() + '__________________________');
    });
  }

  void getCurrentLocation() async {
    Position currentPosition =
    await GeolocatorPlatform.instance.getCurrentPosition();
    setState(() {
      position = currentPosition;
    });
  }

  void getCurrentSubLocality() async {
    final coordinated = geoCo.Coordinates(
        position.latitude, position.longitude);
    var address = await geoCo.Geocoder.local.findAddressesFromCoordinates(
        coordinated);
    var firstAddress = address.first;
    setState(() {
      myCurrentSubLocality = firstAddress.subLocality;
    });
  }

  String text ="error";

  Future<void> _enrollCourse() async {
    getCurrentLocation();

    final coordinated = new geoCo.Coordinates(
        firstMarker.latitude, firstMarker.longitude);
    var address = await geoCo.Geocoder.local
        .findAddressesFromCoordinates(coordinated);
    var firstAddress = address.first;

    await FirebaseFirestore.instance.collection('Course').add({
      'From': this.uid,
      //uid 출력.
      'course_info' : {
        'course_addr' : firstAddress.addressLine,
        'course_name' : text,
        'course_writer' : loggeduser.displayName,
      },
      'course_markers' : [threeMarkers[0],threeMarkers[1],threeMarkers[2]],
    });
    _popupDialog3(context);
  }

  Future<void> _toMain() async {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) =>
            MainPage(uid: this.uid, loggeduser: this.loggeduser,)));
  }


  @override
  Widget build(BuildContext context) {
    print(mid);
    //Stack을 이용해보기?
    return Scaffold(
      //extendBodyBehindAppBar: true,
      body: Container(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              child: GoogleMap(
                //padding은 MyLocationButton을 위치조정 하기 위한 방안임.
                padding: EdgeInsets.only(top: 100.0,),
                //compassEnabled: true,
                //trafficEnabled: true,
                //밑에4개 유저위치 실시간~
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                //zoomGesturesEnabled: true,
                //zoomControlsEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  setState(() {
                    googleMapController = controller;
                    //밑2개 현재 실시간위치
                    _controllerGoogleMap.complete(controller);
                   //currentlocatePosition();
                  });
                },
                initialCameraPosition: CameraPosition(
                    target: LatLng(37.5172, 127.0473),
                    // target: markers[mid].position,
                    zoom: 15.0),
                markers: Set<Marker>.of(markers.values),
              ),
            ),
            Positioned(
              top: 40,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) =>
                          MainPage(uid: this.uid, loggeduser: this.loggeduser,)));
                },
              ),
            ),
            // 코포를 쓴다 하면 이쪽 부분을 삭제하시면 되요.
            Positioned(
              left: 40,
              top: 35,
              child: SearchMapPlaceWidget(
                //language: 'ko' 되잖아악
                language: 'ko',
                hasClearButton: true,
                //삭제버튼
                placeType: PlaceType.address,
                placeholder: '주소입력',
                apiKey: 'AIzaSyC0vAxFsUvf3bafFQlG-3y3Pe1y94KBbi8',
                //geolocation은 future이니까 async하고 await필요.
                onSelected: (Place place) async {
                  Geolocation geolocation = await place.geolocation;
                  googleMapController.animateCamera(
                      CameraUpdate.newLatLng(
                          geolocation.coordinates
                      )
                  );
                  googleMapController.animateCamera(
                      CameraUpdate.newLatLngBounds(geolocation.bounds, 0)
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _popupDialog2(BuildContext context) async {
    Alert(
      context: context,
      //type: AlertType.error,
      title: "등록완료!",
      desc: "제목을 입력해주세요.",
      content: TextField(
        decoration: new InputDecoration(hintText: "제목"),
        controller: _c,
      ),
      buttons: [
        DialogButton(
          child: Text(
            "확인",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            setState(() {
              text = _c.text;
            });
            _enrollCourse();
          },
          width: 120,
        ),
      ],
    ).show();
  }
  void _popupDialog3(BuildContext context) async {
    Alert(
      context: context,
      //type: AlertType.error,
      title: "완료!",
      buttons: [
        DialogButton(
          child: Text(
            "확인",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            _toMain();
          },
          width: 120,
        ),
      ],
    ).show();
  }

  @override
  void dispose() {
    super.dispose();
  }
}




