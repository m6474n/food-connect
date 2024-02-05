import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/components/card.dart';
import 'package:get/get.dart';

class AdminController extends GetxController {
  final userStream = FirebaseFirestore.instance.collection('Users').snapshots();
  final donationStream =
      FirebaseFirestore.instance.collection('donations').snapshots();

  getUsers() {
    return StreamBuilder(
        stream: userStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {
            return Center(child: Text("Something went wrong!"));
          }

          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var id = snapshot.data!.docs[index]['id'];
                return ListTile(
                  onTap: (){

                  },
                  leading: CircleAvatar(),
                  title: Text('Name'),
                  subtitle: Text('Email'),
                  trailing: Text('Role'),
                );
              });
        });
  }

  getDonations() {
    return StreamBuilder(
        stream: donationStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {
            return Center(child: Text("Something went wrong!"));
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return DonationCard(
                    item: "item",
                    quantity: "quantity",
                    restaurentName: "restaurentName",
                    time: 12,
                    address: "address",
                    status: "status",
                    onTap: () {},
                    type: "Veg");
              });
        });
  }

  deleteUser(){
    FirebaseFirestore.instance.collection('Users');
  }


}
