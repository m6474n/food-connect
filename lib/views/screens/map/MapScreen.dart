import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/components/GradientButton.dart';
import 'package:food_donation_app/components/searchField.dart';
import 'package:food_donation_app/controller/LocationController.dart';
import 'package:food_donation_app/controller/mainMapController.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocationController>(context, listen: true);
    return GetBuilder(
        init: MainMapController(),
        builder: (controller){
      return Scaffold(
          floatingActionButton:FloatingActionButton(
            onPressed: () {
              controller.moveToCurrentLocation();

             },
            backgroundColor: mainColor,
            child: const Icon(
              Icons.my_location,
              color: Colors.white,
            ),
          ),
          body: Stack(
            children: [
              controller.loadMap(),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
                    SearchField(
                      controller: controller.searchController,
                      label: 'your_address'.tr,
                      onTap: () {},
                    ),
                    Get.find<MainMapController>().searchController.text ==""?Container(): Expanded(
                      // height: 200,
                      // color: .grey.shade100,
                      child: ListView.builder(
                          itemCount: controller.placeList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.grey.shade100,
                              child: ListTile(
                                onTap: () {
                                  controller.updateScreen(
                                    controller.placeList[index]['description'],
                                  );
                                  controller.placeList.clear();
                                  controller.searchController.clear();
                                },
                                title: Text(
                                    controller.placeList[index]['description']),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.center,
                  child: controller.searchController.text == ''
                      ? Container()
                      : Image(
                    image: AssetImage(
                      'asset/marker.png',
                    ),
                    height: 15,
                  ))
            ],
          ));
    });
  }
}
