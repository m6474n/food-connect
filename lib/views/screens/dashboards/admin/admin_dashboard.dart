import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/components/card.dart';
import 'package:food_donation_app/controller/AdminController.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/utility/utils.dart';
import 'package:food_donation_app/views/screens/authentication/login.dart';
import 'package:food_donation_app/views/screens/dashboards/admin/ManageDonations.dart';
import 'package:food_donation_app/views/screens/dashboards/admin/ManageNGOs.dart';
import 'package:food_donation_app/views/screens/dashboards/admin/ManageRestaurants.dart';
import 'package:get/get.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AdminController(),
      builder: (controller) {
        return Scaffold(
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
            ),
            body: Container(
              child: Column(
                children: [
                  Container(
                    height: 200,
                    color: Colors.grey.shade200,
                    child: Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(
                              left: 18, top: 18, bottom: 18, right: 9),
                          child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(24)),
                            padding: EdgeInsets.all(12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    controller.getUserList(),
                                    Icon(
                                      Icons.person,color: Colors.white,
                                      size: 50,
                                    )
                                  ],
                                ),
                                Text(
                                  'Active Users',
                                  style: paragraph.copyWith(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        )),
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 18, top: 18, bottom: 18, right: 9),
                              child: Container(
                                height: 120,
                                decoration: BoxDecoration(
                                    color: mainColor,
                                    borderRadius: BorderRadius.circular(24)),
                                padding: EdgeInsets.all(12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                       controller.getDonationList(),
                                        SizedBox(width: 6,),
                                        Icon(
                                          Icons.fastfood_rounded,color: Colors.white,
                                          size: 40,
                                        )
                                      ],
                                    ),
                                    Text(
                                      'Donations',
                                      style: paragraph.copyWith(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            )),
                        // Expanded(
                        //     child: Padding(
                        //   padding: const EdgeInsets.only(
                        //       left: 9, top: 18, bottom: 18, right: 18),
                        //   child: Container(
                        //     height: 150,
                        //     color: mainColor,
                        //     decoration: BoxDecoration(),
                        //   ),
                        // ))
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(6),
                    child: Column(
                      children: [
                        Reuseable("Manage Restaurants", () {
                          Get.to(()=> const ManageRestaurants());
                        }),
                        Reuseable("Manage NGOs", () {
                          Get.to(()=> const ManageNGOs());
                        }),
                        Reuseable("Manage Donations", () {
                          Get.to(()=> ManageDonations());
                        }),
                      ],
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }
}

Widget Reuseable(String title, VoidCallback onTap) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
          height: 60,
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12)),
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      title,
                      style: paragraph.copyWith(color: Colors.black87),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                      child: Container(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.navigate_next,
                          )))
                ]),
          )),
    ),
  );
}
