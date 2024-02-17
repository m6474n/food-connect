import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/Services/DestinationController.dart';
import 'package:food_donation_app/components/GradientButton.dart';
import 'package:food_donation_app/components/InputField.dart';
import 'package:food_donation_app/components/card.dart';
import 'package:food_donation_app/Services/Role_manager.dart';
import 'package:food_donation_app/Services/Session_manager.dart';
import 'package:food_donation_app/controller/donationController.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/routes/routes.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/views/screens/donation/addDonation.dart';
import 'package:food_donation_app/views/screens/donation/donationDetails.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class DonationScreen extends StatefulWidget {
  const DonationScreen({super.key});

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  final productController = TextEditingController();
  final qtyController = TextEditingController();
  final productNode = FocusNode();
  final qtyNode = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      RoleController().role = value['role'];
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    productController.dispose();
    qtyController.dispose();
    productNode.dispose();
    qtyNode.dispose();
  }

  final ref = FirebaseFirestore.instance.collection('Donations');
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
              child: Text(
            'donations'.tr,
            style: Heading1.copyWith(fontSize: 24),
          )),
        ),
        body: GetBuilder(
          init: DonationController(),
          builder: (controller){
          return controller.getDonations();
        },),
        floatingActionButton: RoleController().role == 'Restaurant'
            ? FloatingActionButton(
                onPressed: () {
                  Get.to(AddDonation());
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                backgroundColor: mainColor,
              )
            : null,
      ),
    );
  }
}
