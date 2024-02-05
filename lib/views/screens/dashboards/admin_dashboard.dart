import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/components/card.dart';
import 'package:food_donation_app/controller/AdminController.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/utility/utils.dart';
import 'package:food_donation_app/views/screens/authentication/login.dart';
import 'package:get/get.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final userRef = FirebaseFirestore.instance.collection('Users');
  final donationRef = FirebaseFirestore.instance.collection('donations');
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child:GetBuilder(
        init: AdminController(),
        builder: (controller){
        return  Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              'Admin Dashboard',
              style: TextStyle(color: mainColor),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      Get.to(LoginScreen());
                      Utils.toastMessage('Logout!', Colors.red);
                    });
                  },
                  icon: Icon(Icons.logout))
            ],
            bottom: TabBar(
              labelColor: mainColor,
              labelStyle: paragraph,
              indicatorColor: mainColor,
              tabs: [
                Tab(
                  child: Text('Users'),
                ),
                Tab(
                  child: Text('Donations'),
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Container(
                child: controller.getUsers(),
              ),
              Container(
                child: controller.getDonations(),
              )
            ],
          ),
        );
      },)
    );
  }
}
