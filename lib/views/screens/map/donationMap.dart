import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:food_donation_app/components/ColorButton.dart';
import 'package:food_donation_app/components/GradientButton.dart';
import 'package:food_donation_app/Services/LocationManager.dart';
import 'package:food_donation_app/controller/mappController.dart';
import 'package:food_donation_app/controller/routeController.dart';
import 'package:food_donation_app/views/screens/dashboards/dashboard.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DonationMap extends StatelessWidget {
  final String id;
  DonationMap({
    super.key, required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MapController(),
      builder: (controller) {
        return Scaffold(body: Stack(
          children: [
            controller.loadMap()
          ],
        ), floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(18.0),
            child:controller.isRouteStarted?
           controller.isDonationPicked? ColorButton(label: "Donations Picked!", color: Colors.green, onPress: (){}, loading: false)
                : ColorButton(label: "Pick Donation", onPress: (){
                  controller.getRating(context);
             // controller.isDonationPicked = true;
             FirebaseFirestore.instance.collection('donations').doc(id.toString()).update(
                 {
                   'status': "Completed"
                 }).then((value) {
                   EasyLoading.showSuccess('Donation Picked!');
                   Get.to(DashboardScreen());
             });
           }, loading: false, color: Colors.yellow,)

                : GradientButton(
              label: 'Start',
              onPress: () {
controller.isRouteStarted = true;
                controller.updateCameraLocation();

              },
              loading: false,
            ),
          ),);
      },
    );
  }
}
