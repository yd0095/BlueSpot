import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart' as geoCo;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:permission/permission.dart';
import 'dart:async';
import 'package:bluespot/pages/mainPage.dart';
import 'package:kopo/kopo.dart';
import 'package:bluespot/pages/loginPage.dart';

// 중요! GCP 환경설정에서 direction api, maps sdk for android를 허용해야한다.
// 중요! direction을 이용하기전에 해당 기기의 위치를 사용하는 것에 대해서 권한을 받아야 한다.
//  -> location이 enabled되어 있는지 확인을 해야하고 유저에게 해당 기기의 현재 위치 사용 권한을 허락 받아야 한다.


class MapPage extends StatefulWidget {
  final String uid;
  MapPage({Key key, @required this.uid,}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState(uid);
}

class _MapPageState extends State<MapPage> {
  var mid;
  String addressJSON = '';
  GoogleMapController googleMapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Position position;
  String addressLocation;
  String country;

  //여기서부터 내실시간 위치.
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  Position currentPosition;       //내현재위치
  var geoLocator = Geolocator();

  final String uid;
  _MapPageState(this.uid);  //현재위치


  //실제위치 받아오는 함수.
  void currentlocatePosition() async{
    //Accuracy.bestForNavigation도 굳.
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = position; //position에서 lat,lng를 받아온다.

    //객체 생성해서 고도위도 넣음.
    LatLng latPosition = LatLng(position.latitude, position.longitude);

    //카메라 이동하기 위해선 현재 위치를 알아야하니까. 현재위치 알아내서 현재위치로 카메라 업데이트.
    CameraPosition cameraPosition = new CameraPosition(target: latPosition, zoom: 14.0);
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  //init amrker, getMarker가 retrieve function. -> 실행안댐.
  //처음 실행하면 마커를 불러오기위해서 초기화하는 함수.
  void initMarker(specify, specifyId) async {
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position:
      LatLng(specify['location'].latitude, specify['location'].longitude),
    );
    setState(() {
      markers[markerId] = marker;
      this.mid = markerId;
    });
  }

  /*
  //firestore에서 마커를 가지고 오는 함수.
  getMarkerData() async {
    FirebaseFirestore.instance.collection('marker').get().then((myMockDoc) {
      if (myMockDoc.docs.isNotEmpty) {
        for (int i = 0; i < myMockDoc.docs.length; i++) {
          initMarker(myMockDoc.docs[i].data(), myMockDoc.docs[i].id);
        }
      }
    });
  }
*/

  void getMarkers(double lat, double long,) {
    MarkerId markerId = MarkerId(lat.toString() + long.toString());
    mid = markerId;
    Marker _marker = Marker(
        markerId: markerId,
        position: LatLng(lat, long),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        //infoWindow: InfoWindow(snippet: addressLocation)
        infoWindow: InfoWindow(title: "input", snippet: "data")
    );
    setState(() {
      markers[markerId] = _marker;
      print(markerId);  //ㄷㅂㄱ
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

  @override
  Widget build(BuildContext context) {
    print(mid);
    //Stack을 이용해보기?
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/AfterLogin');
            }
          ),
          title:  Text('Blue Spot', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          iconTheme: new IconThemeData(color: Colors.grey),
          actions:<Widget>[
            IconButton(
              icon: Icon(Icons.map),
              tooltip: '맵세팅',
              onPressed: () async {
                KopoModel model = await Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => Kopo(),
                    )
                );
                print(model.toJson());
                setState(() {
                  print(MarkerId);
                  addressJSON =
                  '${model.address} ${model.buildingName}${model.apartment == 'Y' ? '아파트' : ''} ${model.zonecode} ';
                });
              },
            ),
            Text('$addressJSON'),
          ]
      ),
      body: Container(
        child: Column(
          children: [
            //코포를 쓴다 하면 이쪽 부분을 삭제하시면 되요.
            // SearchMapPlaceWidget(
            //   //language: 'kor', 한국말 안되는듯...
            //   hasClearButton: true, //삭제버튼
            //   placeType: PlaceType.address,
            //   placeholder: '주소입력',
            //   apiKey: 'AIzaSyC0vAxFsUvf3bafFQlG-3y3Pe1y94KBbi8',
            //   //geolocation은 future이니까 async하고 await필요.
            //   onSelected: (Place place) async{
            //     Geolocation geolocation = await place.geolocation;
            //     googleMapController.animateCamera(
            //         CameraUpdate.newLatLng(
            //             geolocation.coordinates
            //         )
            //     );
            //     googleMapController.animateCamera(
            //         CameraUpdate.newLatLngBounds(geolocation.bounds, 0)
            //     );
            //   },
            // ),
            SizedBox(
              height: 600.0,
              child: GoogleMap(
                  onTap: (tapped) async {
                    final coordinated = new geoCo.Coordinates(tapped.latitude, tapped.longitude);
                    var address = await geoCo.Geocoder.local.findAddressesFromCoordinates(coordinated);
                    var firstAddress = address.first;
                    getMarkers(tapped.latitude, tapped.longitude);
                    await FirebaseFirestore.instance.collection('Marker').doc(firstAddress.countryName).collection(firstAddress.adminArea).add({
                      'uid' : this.uid, //uid 출력.
                      'markerId': markers.keys.toString(),  //markerId
                      'lat, long': [tapped.latitude, tapped.longitude], //위도와 경도를 배열로 출력
                      'Country': firstAddress.countryName,  //나라
                      'admin' : firstAddress.adminArea,     //시
                      'sublocality' : firstAddress.subLocality,  //구
                      'thoroughfare' : firstAddress.thoroughfare, //도로명
                      'Address': firstAddress.addressLine,  //전체주소
                    });
                    /*
                    String myaddr = "";
                    String name = firstAddress.countryName;
                    String subLocality = firstAddress.subLocality;
                    String Locality = firstAddress.locality;
                    myaddr = "${name}, ${Locality}, ${subLocality}";
                    print(myaddr);
                     */
                    setState(() {
                      country = firstAddress.countryName;
                      addressLocation = firstAddress.addressLine;
                    });
                  },
                  //compassEnabled: true,
                  //trafficEnabled: true,
                  //밑에4개 유저위치 실시간~
                  myLocationButtonEnabled:true,
                  myLocationEnabled: true,
                  //zoomGesturesEnabled: true,
                  //zoomControlsEnabled: true,
                  onMapCreated: (GoogleMapController controller) {
                    setState(() {
                      googleMapController = controller;
                      //밑2개 현재 실시간위치
                      _controllerGoogleMap.complete(controller);
                      currentlocatePosition();
                    });
                  },
                  initialCameraPosition: CameraPosition(
                      target: LatLng(37.5172,127.0473),
                      zoom: 15.0),
                  markers: Set<Marker>.of(markers.values)),
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


