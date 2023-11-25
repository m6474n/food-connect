import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/views/boarding_screen.dart';
import 'package:food_donation_app/views/dashboard.dart';

class SplashService {
  FirebaseAuth auth = FirebaseAuth.instance;

  isLogin(BuildContext context) {
    FirebaseAuth auth  = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user !=null){
  Timer(Duration(seconds: 3),(){
    Navigator.pushNamed(context, RouteName.homeScreen);
  });


    }else{
    Timer(Duration(seconds: 3), () {
     Navigator.pushNamed(context, RouteName.boardingScreen);
    });
  }}
}




