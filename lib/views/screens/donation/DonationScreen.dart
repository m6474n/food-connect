import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/components/GradientButton.dart';
import 'package:food_donation_app/components/InputField.dart';
import 'package:food_donation_app/components/card.dart';
import 'package:food_donation_app/controller/Session_manager.dart';
import 'package:food_donation_app/models/product_model.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/routes/routes.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/views/screens/donation/addDonation.dart';
import 'package:provider/provider.dart';

import '../../../models/list_Provider.dart';
import '../../../models/list_model.dart';

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
  final List _list = [];

  addProduct(value) {
    setState(() {
      _list.add(value);
    });
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

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false  ,
          title: Center(
              child: Text(
            'Donations',
            style: Heading1.copyWith(fontSize: 24),
          )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ListView.builder(itemBuilder: (context, index){
            return CardContiner();
          }),
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddDonation()));
        },child: Icon(Icons.add, color: Colors.white,),backgroundColor: mainColor,),
      ),
    );
  }
}
