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
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:provider/provider.dart';


// 중요! GCP 환경설정에서 direction api, maps sdk for android를 허용해야한다.
// 중요! direction을 이용하기전에 해당 기기의 위치를 사용하는 것에 대해서 권한을 받아야 한다.
//  -> location이 enabled되어 있는지 확인을 해야하고 유저에게 해당 기기의 현재 위치 사용 권한을 허락 받아야 한다.


class Recommend extends StatefulWidget {
  final String uid;
  final User loggeduser;
  Recommend({Key key, @required this.uid, this.loggeduser}) : super(key: key);

  @override
  _RecommendState createState() => _RecommendState(uid,loggeduser);
}

class _RecommendState extends State<Recommend> {

  final String uid;
  final User loggeduser;

  _RecommendState(this.uid, this.loggeduser); //현재위치

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot> currentStream;

  List<MarkerId> midList;
  var mid;

  var mid1;
  var mid2;
  var mid3;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  //polyline

  Map<PolylineId, Polyline> _poly = {};
  List<LatLng> polylineCoordinates = [];
  List<LatLng> polylineCoordinates2 = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = 'AIzaSyC0vAxFsUvf3bafFQlG-3y3Pe1y94KBbi8';


  var pos;
  LatLng _center;
  bool swi;

  int i = 0;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // getCurrentLocation();
      _getPolyline();
      _getPolyline2();

    });

  }


  var sendMid;
  String addressJSON = '';
  GoogleMapController googleMapController;

  var markerLike;
  Position position;
  String addressLocation;
  String country;

  var myCurrentSubLocality;

  String addr; //spotMakePage로 넘겨줄 스팟의 전체 주소(인천광역시 미추홀구 용현동...)


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

  void _cameraUpdate() async{

    LatLng latPosition = LatLng(_originLat, _originLon);

    CameraPosition cameraPosition = new CameraPosition(
        target: latPosition, zoom: 15.0);

    googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition));

  }



  //init amrker, getMarker가 retrieve function. -> 실행안댐.
  //처음 실행하면 마커를 불러오기위해서 초기화하는 함수.
  initMarker(specify, specifyId) async {
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
        markerId: markerId,
        icon: BitmapDescriptor.defaultMarker,
        position:
        LatLng(specify['lat, long'][0], specify['lat, long'][1]),
    );
    setState(() {
      if (markers.length<3) {
        mid = markerId;
        //midList.add(markerId);
        if(mid1 == null){
          mid1 = markerId;
          _originLat = marker.position.latitude;
          _originLon = marker.position.longitude;
          _cameraUpdate();
        }
        else if(mid2 == null) {
          mid2 = markerId;
          _destLat = marker.position.latitude;
          _destLon = marker.position.longitude;
        }
        else{
          mid3 = markerId;
          _wayLat = marker.position.latitude;
          _wayLon = marker.position.longitude;
        }
        markers[markerId] = marker;
      }
    });
  }

  getMarkerData() async {
    //원래는 현재위치 받아야함 ->핸드폰에서 myCurrentSubLocality를 getCurrentSubLocality를 통해 받을거임
    //myCurrentSubLocality = getCurrentLocality();
    var myCurrentLocality = "Incheon";
    //myCurrentSubLocality = getCurrentSubLocality();
    // var myCurrentSubLocality = "Nam-gu";
    // await FirebaseFirestore.instance.collectionGroup(myCurrentLocality).where("sublocality", isEqualTo: myCurrentSubLocality)
    await FirebaseFirestore.instance.collectionGroup(myCurrentLocality)
        .get()
        .then((myMockDoc) {
      for (int i = 0; i < 3; i++) {
        initMarker(myMockDoc.docs[i].data(), myMockDoc.docs[i].id);
      }
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

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
    Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly1");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    _poly[id] = polyline;
    setState(() {});
  }
  _addPolyLine2() {
    PolylineId id = PolylineId("poly2");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.blue, points: polylineCoordinates2);
    _poly[id] = polyline;
    setState(() {});
  }

  // LatLng srt;
  // LatLng dst;
  double _originLat, _originLon;
  double _destLat, _destLon;
  double _wayLat, _wayLon;



  // double _originLatitude = 6.5212402, _originLongitude = 3.3679965;
  // double _destLatitude = 6.849660, _destLongitude = 3.648190;

  // double _originLatitude = 43.623880, _originLongitude = 3.898790;
  // double _destLatitude = 43.623880, _destLongitude = 3.91256;


  void _getPolyline() async {
    await getMarkerData().then((value) async{
      print("$_originLat,$_originLon");
      print("$_destLat,$_destLon");

      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyC0vAxFsUvf3bafFQlG-3y3Pe1y94KBbi8',
        PointLatLng(_originLat, _originLon),
        PointLatLng(_destLat, _destLon),

        travelMode: TravelMode.transit,
          wayPoints: [PolylineWayPoint(location:'')]

      );
      print("${result.points} 1 is success");
      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      }
      _addPolyLine();
    }
    );
  }
  void _getPolyline2() async {
    await getMarkerData().then((value) async{

      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyC0vAxFsUvf3bafFQlG-3y3Pe1y94KBbi8',

        PointLatLng(_wayLat, _wayLon),
        PointLatLng(_destLat, _destLon),

        travelMode: TravelMode.transit,
        //wayPoints: [PolylineWayPoint(location:'$_wayLat$_wayLon,')]
      );
      print("${result.points} 1 is success");
      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) {
          polylineCoordinates2.add(LatLng(point.latitude, point.longitude));
        });
      }
      _addPolyLine2();
    }
    );
  }

  @override
  Widget build(BuildContext context) {
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
                      tiltGesturesEnabled: true,
                      compassEnabled: true,
                      scrollGesturesEnabled: true,
                      zoomGesturesEnabled: true,
                      //zoomGesturesEnabled: true,
                      //zoomControlsEnabled: true,
                      onMapCreated: (GoogleMapController controller) {
                        setState(() {
                          googleMapController = controller;
                          //밑2개 현재 실시간위치
                          _controllerGoogleMap.complete(controller);
                          // currentlocatePosition();
                        });
                      },
                      initialCameraPosition: CameraPosition(
                          target: LatLng(37.5172, 127.0473),
                          zoom: 15),
                      markers: Set<Marker>.of(markers.values),
                      polylines: Set<Polyline>.of(_poly.values),
                    )
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
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
}




