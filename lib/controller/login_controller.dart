import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/controller/notification_services.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/utility/utils.dart';
import 'package:food_donation_app/views/screens/authentication/forget_pass.dart';
import 'package:food_donation_app/views/screens/authentication/login.dart';
import 'package:food_donation_app/views/screens/dashboards/dashboard.dart';
import 'package:food_donation_app/views/screens/profile/complete_profile.dart';
import 'package:get/get.dart';



class LoginProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  NotificationServices notify = NotificationServices();
  final tokenRef = FirebaseFirestore.instance.collection('Devices');

  final FirebaseAuth auth = FirebaseAuth.instance;
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void Login(BuildContext context, String email, String password) async{
    setLoading(true);

    auth
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) async{
          DocumentSnapshot ref = await FirebaseFirestore.instance.collection("Users").doc(auth.currentUser!.uid).get();
         if(ref.exists){
           setLoading(false);
           Utils.toastMessage("Login Successfully", Colors.green);
           Get.to(DashboardScreen());
         }
         else{
           setLoading(false);
           Utils.toastMessage("User deleted by Admin!", Colors.green);
          auth.signOut().then((value) {
            Get.to(LoginScreen());
          });
         }


    }).catchError((e) {
      Utils.toastMessage(e.toString(), Colors.green);
    }).whenComplete(() {
      setLoading(false);
    });
  }

  forgetPassword(String email){
    auth.sendPasswordResetEmail(email: email).then((value) {
      Utils.toastMessage("Password reset link has been sent to your email!", Colors.green);
      Get.to(ForgetPassScreen());
    }).onError((error, stackTrace){
      Utils.toastMessage(error.toString(), Colors.red);

    })
    ;
  }

}
