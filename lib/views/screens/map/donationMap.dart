import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:food_donation_app/components/GradientButton.dart';
import 'package:food_donation_app/Services/LocationManager.dart';
import 'package:food_donation_app/controller/mappController.dart';
import 'package:food_donation_app/controller/routeController.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DonationMap extends StatelessWidget {
  DonationMap({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: MapController(),
        builder: (controller) {
          return Stack(
            children: [
             controller.loadMap()
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(18.0),
        child: GradientButton(
          label: 'Start',
          onPress: () {

            print(Get.find<MapController>().points);

            },
          loading: false,
        ),
      ),
    );
  }
}
