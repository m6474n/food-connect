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

  final dbRef = FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid.toString());
  final mrker = FirebaseFirestore.instance.collection('markers').doc(FirebaseAuth.instance.currentUser!.uid.toString());
  String name="";
  final List<Marker> _markers =  <Marker>[

  ];

  Future<Position> getCurrentLocation() async {

    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print(error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }
  void getUserName()async{
    final response = await dbRef.get();
    name = response.data()!['name'];
  }

  Completer<GoogleMapController> _controller = Completer();


@override
  void initState() {
    // TODO: implement initState

  getUserName();
  super.initState();
  }

  static const LatLng _initialPosition = LatLng(32.5319239, 74.0880223);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: loadMap(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              getCurrentLocation().then((value) async {
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