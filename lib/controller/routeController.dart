import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:food_donation_app/Services/DestinationController.dart';
import 'package:food_donation_app/Services/SourceController.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteController extends GetxController {

  final dbRef = FirebaseFirestore.instance;




  addSourceToFirebase() {


      dbRef.collection('Route').doc('Source').set({
        'id': 'Source',
        'lat': SourceController().source == null? "":SourceController().source!.latitude,
        'long':  SourceController().source == null? "":SourceController().source!.longitude,
        'title': 'Source',
      });

  }



  addDestinationToFirebase() {
      dbRef.collection('Route').doc('Destination').set({
        'id': "Destination",
        'lat': DestinationController().destination == null ? "":DestinationController().destination!.latitude,
        'long':  DestinationController().destination == null ? "": DestinationController().destination!.longitude,
        'title': 'Destination'
    });
  }

  List<Marker> markers = [];

  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
  }


}
