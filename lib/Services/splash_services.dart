import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/Services/Role_manager.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/views/screens/welcome_screens/boarding_screen.dart';
import 'package:food_donation_app/views/screens/dashboards/dashboard.dart';
import 'package:get/get.dart';
class SplashService {
  FirebaseAuth auth = FirebaseAuth.instance;

  isLogin(BuildContext context) async{
    FirebaseAuth auth  = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user !=null){
      var role = await FirebaseFirestore.instance.collection('Users').doc(auth.currentUser!.uid).get();
      RoleController().role = role['role'];
  Timer(Duration(seconds: 3),(){
    Get.to(DashboardScreen());
  });


    }else{
    Timer(Duration(seconds: 3), () {
    Get.to(BoardingScreen());
    });
  }}
}




