import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

class MainMapController extends GetxController{


  final auth = FirebaseAuth.instance;
  final dbRef = FirebaseFirestore.instance.collection('Users');
  final makerRef = FirebaseFirestore.instance.collection('markers');
  Completer<GoogleMapController> completer = Completer();
  LatLng _initialPosition = LatLng(32.5749544, 74.0896053);
  final TextEditingController searchController = TextEditingController();

  String newAddress = '';

  final List<Marker> _markers = <Marker>[];

double? lat,long;
String? address;

  loadMap() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('markers').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            _markers.add(Marker(
                markerId: MarkerId(
                  i.toString(),
                ),
                position: LatLng(snapshot.data!.docs[i]['lat'],
                    snapshot.data!.docs[i]['long']),
                infoWindow:
                InfoWindow(title: snapshot.data!.docs[i]['place'])));
          }
          return GoogleMap(
            markers: Set<Marker>.of(_markers),
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              completer.complete(controller);
            },
            onTap: (LatLng position)async{
              lat = position.latitude;
              long = position.longitude;

              List<Placemark> _placemark = await placemarkFromCoordinates(
                  position.latitude, position.longitude);

              newAddress =
              '${_placemark.reversed.last.street.toString()}, ${_placemark.reversed.last.administrativeArea.toString()}';

              dbRef.doc(auth.currentUser!.uid).update({
                'address': newAddress,
                'longitude': position.longitude,
                'latitude': position.latitude
              }).then((value) {
                addMarker(lat, long);
              }).onError((error, stackTrace){
                Get.snackbar(error.toString(),'', backgroundColor: Colors.red);
              });

update();
            },

            initialCameraPosition:
            CameraPosition(target: _initialPosition, zoom: 14),
          );

        });


  }

   Future<Position> determinePosition() async {
     bool serviceEnabled;
     LocationPermission permission;
     serviceEnabled = await Geolocator.isLocationServiceEnabled();
     if (!serviceEnabled) {
       return Future.error('Location services are disabled.');
     }
     permission = await Geolocator.checkPermission();
     if (permission == LocationPermission.denied) {
       permission = await Geolocator.requestPermission();
       if (permission == LocationPermission.denied) {
         return Future.error('Location permissions are denied');
       }
     }
     if (permission == LocationPermission.deniedForever) {
       return Future.error(
           'Location permissions are permanently denied, we cannot request permissions.');
     }
     return await Geolocator.getCurrentPosition();


   }


   moveToCurrentLocation(){
     determinePosition().then((value) async {
       lat = value.latitude;
       long = value.longitude;
       var local  =await placemarkFromCoordinates(value.latitude, value.longitude);
      var addr= "${local.reversed.last.street}, ${local.reversed.last.subLocality}, ${local.reversed.last.country}";
       dbRef.doc(auth.currentUser!.uid).update({
         'address': addr,
         'longitude': value.longitude,
         'latitude': value.latitude
       }).then((value) {
         addMarker(lat, long);
       }).onError((error, stackTrace){
         Get.snackbar(error.toString(),'', backgroundColor: Colors.red);
       });
       // add marker into local list
       // provider.UpdateLocation(
       //     newAddress, value.longitude, value.latitude);
       // create new camera position to animate
       CameraPosition camera = CameraPosition(
           target: LatLng(value.latitude, value.longitude),
           zoom: 14);
       GoogleMapController controller = await completer.future;

         controller
             .animateCamera(CameraUpdate.newCameraPosition(camera));
       }); //

     update();

   }
  void addMarker(lat, long){
    makerRef.doc(auth.currentUser!.uid).set({
      'lat': lat,
      'long': long,
      'place': auth.currentUser!.displayName
    }).then((value){
      Get.snackbar('Location Updated Successfully!','');
      // Utils.toastMessage('Location Updated', Colors.green);
    }).onError((error, stackTrace){
      // Utils.toastMessage(error.toString(), Colors.red);
      Get.snackbar(error.toString(),'', backgroundColor: Colors.red);
    });
  }


  void UpdateLocation() {

    dbRef.doc(auth.currentUser!.uid).update({
      'address': address,
      'longitude': long,
      'latitude': lat
    }).then((value) {
      addMarker(lat, long);
    }).onError((error, stackTrace){
      Get.snackbar(error.toString(),'', backgroundColor: Colors.red);
    });
  }

  var uuid = Uuid();
  String _sessionToken = "112233";
  List<dynamic> placeList = [];

  onChanged() {
    if (_sessionToken == null) {
      _sessionToken = uuid.v4();
      update();
    }
    getSuggestions(searchController.text);
  }

  getSuggestions(String input) async {
    String apiKey = "AIzaSyCGXjH2olWHaRbJBH4SRNGmYfX60skyWs8";
    String baseUrl =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseUrl?input=$input&key=$apiKey&sessiontoken=$_sessionToken';

    var response = await http.get(Uri.parse(request));

    print(response.body.toString());

    if (response.statusCode == 200) {
      placeList = jsonDecode(response.body.toString())['predictions'];
    } else {
      throw Exception("Failed to get data");
    }

    update();
  }
  //update screen on search

  updateScreen(
      String address,
      ) async {
    List locals = await locationFromAddress(address);
    print(locals.last.longitude);
    CameraPosition newCameraPosition = CameraPosition(
        target: LatLng(locals.last.latitude, locals.last.longitude), zoom: 12);
    GoogleMapController controller = await completer.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));

    // searchController.text = address;

    update();
  }


@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    navigateToCurrentLocation();
  searchController.addListener(() {
    onChanged();

  });

  }

  navigateToCurrentLocation(){
    determinePosition().then((value) async {
      CameraPosition camera = CameraPosition(
          target: LatLng(value.latitude, value.longitude),
          zoom: 14);
      GoogleMapController controller = await completer.future;

      controller
          .animateCamera(CameraUpdate.newCameraPosition(camera));
    }); //

    update();

  }



}