import 'package:bluespot/pages/myEnrolledPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

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



class MyEnrolledDetailPage extends StatefulWidget {

  final String uid;
  final User loggeduser;
  final String course_id;

  MyEnrolledDetailPage({Key key, @required this.uid, this.loggeduser,this.course_id}) : super(key: key); //현재위치


  @override
  _MyEnrolledDetailPageState createState() => _MyEnrolledDetailPageState(this.uid,this.loggeduser,this.course_id);
}
class _MyEnrolledDetailPageState extends State<MyEnrolledDetailPage> {


  final String uid;
  final User loggeduser;
  final String course_id;

  _MyEnrolledDetailPageState(this.uid, this.loggeduser,this.course_id);
  

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot> currentStream;
  GoogleMapController googleMapController;
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  
  
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  var mid;
  var mid1;
  var mid2;
  var mid3;
  Map<PolylineId, Polyline> _poly = {};
  List<LatLng> polylineCoordinates = [];
  List<LatLng> polylineCoordinates2 = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = 'AIzaSyC0vAxFsUvf3bafFQlG-3y3Pe1y94KBbi8';


  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // getCurrentLocation();
      _getPolyline();
    //  _getPolyline2();

    });
    super.initState();
  }


  void _cameraUpdate() async{

    LatLng latPosition = LatLng(_originLat, _originLon);

    CameraPosition cameraPosition = new CameraPosition(
        target: latPosition, zoom: 15.0);

    googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition));
  }

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
          print(mid1);
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

    var markerid1;
    var markerid2;
    var markerid3;

    await FirebaseFirestore.instance.collection('Course').where("course_id",isEqualTo: this.course_id)
        .get()
        .then((myMockDoc) {
          markerid1 = myMockDoc.docs[0].data()['course_markers'][0];
          markerid2 = myMockDoc.docs[0].data()['course_markers'][1];
          markerid3 = myMockDoc.docs[0].data()['course_markers'][2];
    });


    print("$markerid1  id1");
    print("$markerid2  id2");
    print("$markerid3  id3");


    await FirebaseFirestore.instance.collection('Marker/South Korea/Incheon').where("markerId",isEqualTo: markerid1)
        .get()
        .then((myMockDoc) {
        initMarker(myMockDoc.docs[0].data(), myMockDoc.docs[0].id);
    });
    await FirebaseFirestore.instance.collection('Marker/South Korea/Incheon').where("markerId",isEqualTo: markerid2)
        .get()
        .then((myMockDoc) {
      initMarker(myMockDoc.docs[0].data(), myMockDoc.docs[0].id);
    });
    await FirebaseFirestore.instance.collection('Marker/South Korea/Incheon').where("markerId",isEqualTo: markerid3)
        .get()
        .then((myMockDoc) {
      initMarker(myMockDoc.docs[0].data(), myMockDoc.docs[0].id);
    });
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

  double _originLat, _originLon;
  double _destLat, _destLon;
  double _wayLat, _wayLon;


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
      _getPolyline2();
    }
    );
  }
  void _getPolyline2() async {
    // await getMarkerData().then((value) async{

      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyC0vAxFsUvf3bafFQlG-3y3Pe1y94KBbi8',

        PointLatLng(_destLat, _destLon),
        PointLatLng(_wayLat, _wayLon),

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
    // }
    // );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container( //코스 정보 표시하는 container
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
            // Positioned(
            //   top: MediaQuery.of(context).size.height*0.7,
            //   left: 50,
            //   child: Row(
            //     children: <Widget>[
            //       Container(
            //         padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Container( //코스 분류
            //               margin: EdgeInsets.all(2),
            //               child: Row(
            //                   children:[
            //                     Text('코스 분류:  ',style: GoogleFonts.inter(
            //                       fontSize:18,
            //                       fontWeight: FontWeight.bold,
            //                     ), ),
            //                     Text('먹방 코스',style: GoogleFonts.inter(
            //                       fontSize:18,
            //                       fontWeight: FontWeight.bold,
            //                     ), )
            //                   ]
            //               ),
            //             ),
            //             Container( //코스 등록자
            //               margin: EdgeInsets.all(2),
            //               child: Row(
            //                   children:[
            //                     Text('코스 등록자:  ',style: GoogleFonts.inter(
            //                       fontSize:18,
            //                       fontWeight: FontWeight.bold,
            //                     ), ),
            //                     Text('비룡',style: GoogleFonts.inter(
            //                       fontSize:18,
            //                       fontWeight: FontWeight.bold,
            //                     ), )
            //                   ]
            //               ),
            //             ),
            //             Container( //예상 소요시간
            //               margin: EdgeInsets.all(2),
            //               child: Row(
            //                   children:[
            //                     Text('예상 소요시간:  ',style: GoogleFonts.inter(
            //                       fontSize:18,
            //                       fontWeight: FontWeight.bold,
            //                     ), ),
            //                     Text('1시간 30분',style: GoogleFonts.inter(
            //                       fontSize:18,
            //                       fontWeight: FontWeight.bold,
            //                     ), )
            //                   ]
            //               ),
            //             ),
            //           ],
            //
            //         ),
            //
            //       ),
            //       Expanded( //코스 정보 수정 버튼
            //         child: Stack(
            //           //alignment: Alignment.center,
            //           children: [
            //             Positioned(
            //               right: 20,
            //               top: 45,
            //               child: Icon(
            //                 Icons.edit,
            //                 color: Colors.black,
            //               ),
            //             ),
            //           ],
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            Positioned(
              top: 40,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) =>
                          MyEnrolledPage(uid: this.uid, loggeduser: this.loggeduser,)));
                },
              ),
            ),

          ],
        ) ,
      ),

    );
  }
}