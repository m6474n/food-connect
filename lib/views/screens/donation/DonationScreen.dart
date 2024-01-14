import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/components/GradientButton.dart';
import 'package:food_donation_app/components/InputField.dart';
import 'package:food_donation_app/components/card.dart';
import 'package:food_donation_app/controller/Role_manager.dart';
import 'package:food_donation_app/controller/Session_manager.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/routes/routes.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/views/screens/donation/addDonation.dart';
import 'package:food_donation_app/views/screens/donation/donationDetails.dart';
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
            'Donations',
            style: Heading1.copyWith(fontSize: 24),
          )),
        ),
        body: Container(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('donations')
                .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState) {
                return Center(child: CircularProgressIndicator(color: mainColor,));
              }
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator(color: mainColor,));
              }
              if(snapshot.hasError){
                return Center(child: Text('Something went wrong'));
              }
              if (snapshot.data.docs.isEmpty) {
                return Center(
                    child: Text(
                  'No active donation available',
                  style: paragraph,
                ));
              }
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return DonationCard(
                        item: snapshot.data!.docs[index]['item'],
                        quantity: snapshot.data!.docs[index]['quantity'],
                        restaurentName: snapshot.data!.docs[index]
                            ['donated by'],
                        time: snapshot.data!.docs[index]['prep time'] == null
                            ? ""
                            : snapshot.data!.docs[index]['prep time'],
                        address: snapshot.data!.docs[index]['location'],
                        status: snapshot.data!.docs[index]['status'],
                        onTap: () {}, type:  snapshot.data!.docs[index]['status'],
                      );
                    }),
              );
            },
          ),
        ),
        floatingActionButton: RoleController().role == 'Restaurant'
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddDonation()));
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
