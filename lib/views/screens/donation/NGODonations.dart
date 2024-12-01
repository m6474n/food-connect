import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/Services/DestinationController.dart';
import 'package:food_donation_app/components/card.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/views/screens/donation/donationDetails.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NGODonationScreen extends StatefulWidget {
  const NGODonationScreen({super.key});

  @override
  State<NGODonationScreen> createState() => _NGODonationScreenState();
}

class _NGODonationScreenState extends State<NGODonationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
            child: Text(
          'all_donations'.tr,
          style: Heading1.copyWith(fontSize: 24),
        )),
      ),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('donations')
              .where('status', isEqualTo: 'active')
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState) {
              return Center(
                  child: CircularProgressIndicator(
                color: mainColor,
              ));
            }
            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator(
                color: mainColor,
              ));
            }
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            }
            if (snapshot.data.docs.isEmpty) {
              return Center(
                  child: Text(
                'No donation available',
                style: paragraph,
              ));
            }

            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return DonationCard(
                    item: snapshot.data!.docs[index]['item'],
                    quantity: snapshot.data!.docs[index]['quantity'],
                    restaurentName: snapshot.data!.docs[index]['donated by'],
                    time: snapshot.data!.docs[index]['prep time'],
                    status: snapshot.data!.docs[index]['status'],
                    onTap: () {

                      DestinationController().destination =
                          LatLng(snapshot.data.docs[index]['lat'],
                            snapshot.data.docs[index]['long']);
                    Get.to(DonationDetails(
                      id: snapshot.data.docs[index].id,
                                item: snapshot.data
                                    .docs[index]['item'],
                                type: snapshot.data
                                    .docs[index]['type'],
                                serving: snapshot
                                    .data.docs[index]
                                ['quantity'],
                                time: snapshot
                                    .data.docs[index]
                                ['prep time'],
                                donerId: snapshot.data
                                    .docs[index]['id'],
                                donerName: snapshot
                                    .data.docs[index]
                                ['donated by'],
                                  ));
                    },
                    type: snapshot.data!.docs[index]['type'],
                  );

                });
          },
        ),
      ),
    );
  }
}
