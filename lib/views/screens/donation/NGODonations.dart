import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/components/card.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/views/screens/donation/donationDetails.dart';

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
          'All Donations',
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
                      address: snapshot.data!.docs[index]['location'],
                      status: snapshot.data!.docs[index]['status'],
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DonationDetails()));
                      }, type:  snapshot.data!.docs[index]['type'],);
                });
          },
        ),
      ),
    );
  }
}
