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

// 중요! GCP 환경설정에서 direction api, maps sdk for android를 허용해야한다.
// 중요! direction을 이용하기전에 해당 기기의 위치를 사용하는 것에 대해서 권한을 받아야 한다.
//  -> location이 enabled되어 있는지 확인을 해야하고 유저에게 해당 기기의 현재 위치 사용 권한을 허락 받아야 한다.


class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  GoogleMapController googleMapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Position position;
  String addressLocation;
  String country;

  //여기서부터 내실시간 위치.
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  Position currentPosition;       //내현재위치
  var geoLocator = Geolocator();  //현재위치


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

  void getMarkers(double lat, double long) {
    MarkerId markerId = MarkerId(lat.toString() + long.toString());
    Marker _marker = Marker(
        markerId: markerId,
        position: LatLng(lat, long),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        //infoWindow: InfoWindow(snippet: addressLocation)
        infoWindow: InfoWindow(title: "input", snippet: "data")
    );
    print(markerId);  //ㄷㅂㄱ
    setState(() {
      markers[markerId] = _marker;
      print(markerId);  //ㄷㅂㄱ
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
    //Stack을 이용해보기?
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            //코포를 쓴다 하면 이쪽 부분을 삭제하시면 되요.
            SearchMapPlaceWidget(
              //language: 'kor', 한국말 안되는듯...
              hasClearButton: true, //삭제버튼
              placeType: PlaceType.address,
              placeholder: '주소입력',
              apiKey: 'AIzaSyC0vAxFsUvf3bafFQlG-3y3Pe1y94KBbi8',
              //geolocation은 future이니까 async하고 await필요.
              onSelected: (Place place) async{
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
            SizedBox(
              height: 600.0,
              child: GoogleMap(
                  onTap: (tapped) async {
                    final coordinated = new geoCo.Coordinates(tapped.latitude, tapped.longitude);
                    var address = await geoCo.Geocoder.local.findAddressesFromCoordinates(coordinated);
                    var firstAddress = address.first;
                    getMarkers(tapped.latitude, tapped.longitude);
                    await FirebaseFirestore.instance.collection('Marker').doc(firstAddress.countryName).collection(firstAddress.subLocality).add({
                      'latitude': tapped.latitude,
                      'longitude': tapped.longitude,
                      'Address': firstAddress.addressLine,
                      'Country': firstAddress.countryName,
                      'local' : firstAddress.locality,
                      'sublocal' : firstAddress.subLocality,
                      'admin' : firstAddress.adminArea,
                      'subadmi' : firstAddress.subAdminArea,
                      'thoroughfare' : firstAddress.thoroughfare,
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


