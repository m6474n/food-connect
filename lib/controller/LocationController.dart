import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:food_donation_app/utility/utils.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends ChangeNotifier {

  final auth = FirebaseAuth.instance;
  final dbRef = FirebaseFirestore.instance.collection('Users');
  final makerRef = FirebaseFirestore.instance.collection('markers');




  bool _loading = false;
  bool get Loading => _loading;
  String _address = 'current_address'.tr;
  String get Address => _address;
  double? _long;
  double? get Longitude => _long;
  double? _lat ;
  double? get Latitude => _lat;


  void setLoading(bool value){
    _loading = value;
    notifyListeners();
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

void getCurrentLocation(){
    determinePosition().then((value)async {

      List<Placemark> placemark = await placemarkFromCoordinates(
          value.latitude, value.longitude);
      _long = value.longitude;
      _lat = value.latitude;
      _address = '${placemark.reversed.last.street}, ${placemark.reversed.last.administrativeArea}';

      UpdateLocation(_address, _long, _lat);
      notifyListeners();
    })
       ;






}






  void UpdateLocation(address, longitude, latitude) {
    setLoading(true);
    dbRef.doc(auth.currentUser!.uid).update({
      'address': address,
      'longitude': longitude,
      'latitude': latitude
    }).then((value) {
      addMarker(latitude, longitude);
    }).onError((error, stackTrace){
      Utils.toastMessage(error.toString(), Colors.red);
    });
  }

  void addMarker(lat, long){
    makerRef.doc(auth.currentUser!.uid).set({
      'lat': lat,
      'long': long,
      'place': auth.currentUser!.displayName
    }).then((value){
      setLoading(false);
      Utils.toastMessage('Location Updated', Colors.green);
    }).onError((error, stackTrace){
      Utils.toastMessage(error.toString(), Colors.red);
    });
  }




}
