import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/controller/Session_manager.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}
class _MapScreenState extends State<MapScreen> {
final name = FirebaseAuth.instance.currentUser!.displayName;
  final dbRef = FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid.toString());
  final mrker = FirebaseFirestore.instance.collection('markers').doc(FirebaseAuth.instance.currentUser!.uid.toString());

  final List<Marker> _markers =  <Marker>[

  ];
Future<Position> _determinePosition() async
{

  bool serviceEnabled;


  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();



}


  Completer<GoogleMapController> _controller = Completer();
static const LatLng _initialPosition = LatLng(32.5750722,74.0072032);

@override
  void initState() {
    // TODO: implement initState


  super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: loadMap(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _determinePosition().then((value) async {
                print("Long:" +
                    value.longitude.toString() +
                    " " +
                    "Lat:" +
                    value.latitude.toString());
                _markers.add(
                    Marker(
                        markerId: MarkerId(SessionController().userId.toString()),
                        position: LatLng(value.latitude, value.longitude,

                        ), infoWindow: InfoWindow(title: "My Current Location")

                    )
                );
                CameraPosition cameraPosition = CameraPosition(

                    zoom: 12,
                    target: LatLng(value.latitude, value.longitude,));

                final GoogleMapController controller = await _controller.future;

                setState(() {
                  controller.animateCamera(
                      CameraUpdate.newCameraPosition(cameraPosition));
                });

                List<Placemark> placemark = await placemarkFromCoordinates(
                    value.latitude, value.longitude);
                final address = '${placemark.reversed.last.street
                    .toString()}' ', ' '${placemark.reversed.last.country}';
                final longitude = value.longitude;
                final latitude = value.latitude;
                print(address);
                dbRef.update(
                    {

                      'address': address
                      , 'longitude': longitude,
                      'latitude': latitude
                    }).then((value) {
                      mrker.set({
                        'lat': latitude,'long': longitude,'place': name
                      });
                });
              }).onError((error, stackTrace) {
                print(error.toString());
              });
            },
            child: Icon(
              Icons.location_on,
              color: Colors.white,
            ),
            backgroundColor: mainColor,
          )),
    );
  }

  Widget loadMap() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('markers').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator(color:mainColor,));
          }

          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            _markers.add(new Marker(markerId: MarkerId(i.toString(),
            ), position: LatLng(
                snapshot.data!.docs[i]['lat'],
                snapshot.data!.docs[i]['long']

            ),
                infoWindow: InfoWindow(title: snapshot.data!.docs[i]['place'])
            ));
          }
          return GoogleMap(
            markers: Set<Marker>.of(_markers),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            initialCameraPosition:
            CameraPosition(target: _initialPosition, zoom: 12),
          );
        });
  }
}