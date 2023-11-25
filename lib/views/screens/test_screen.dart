import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

List<Marker> _markers = <Marker>[
  Marker(
      markerId: MarkerId('1'),
      position: LatLng(32.5319239, 74.0880223),
      infoWindow: InfoWindow(title: "Gujrat Main City"))
];

Future<Position> getCurrentLocation() async {
  await Geolocator.requestPermission()
      .then((value) {})
      .onError((error, stackTrace) {
    print(error.toString());
  });

  return await Geolocator.getCurrentPosition();
}

final LatLng _initialPosition = LatLng(32.5319239, 74.0880223);
Completer<GoogleMapController> _controller = Completer();

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: Set<Marker>.of(_markers),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 12,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getCurrentLocation().then((value) async{
            print("lat:" +
                value.latitude.toString() +
                "  " +
                "long:" +
                value.longitude.toString());
            _markers.add(
              Marker(
                  markerId: MarkerId('2'),
                  position: LatLng(value.latitude, value.longitude),
                  infoWindow: InfoWindow(title: 'My Current Location')),
            );

            CameraPosition cameraPosition =
                CameraPosition(
                    zoom: 14,
                    target: LatLng(value.latitude, value.longitude));
            final GoogleMapController controller = await _controller.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {

            });

          });
        },
        child: Icon(
          Icons.location_on,
          color: Colors.white,
        ),
        backgroundColor: mainColor,
      ),
    );
  }
}
