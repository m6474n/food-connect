import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/Services/Role_manager.dart';
import 'package:food_donation_app/Services/Session_manager.dart';
import 'package:food_donation_app/controller/notification_services.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/utility/utils.dart';
import 'package:food_donation_app/views/screens/dashboards/dashboard.dart';
import 'package:food_donation_app/views/screens/profile/complete_profile.dart';
import 'package:get/get.dart';

class RegisterProvider with ChangeNotifier{
  FirebaseAuth auth  = FirebaseAuth.instance;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  NotificationServices notify = NotificationServices();
  final dbRef = FirebaseFirestore.instance.collection('Users');
  final tokenRef = FirebaseFirestore.instance.collection('Devices');
  void setLoading (bool value){
    _isLoading = value;
    notifyListeners();

  }


  void signup(BuildContext context, String name,String email,String password, String role){
    setLoading(true);
    auth.createUserWithEmailAndPassword(email: email, password: password).then((value){
      setLoading(false);
      // final user =  auth.currentUser
      final id = value.user!.uid.toString();
      // SessionController().userId = auth.currentUser!.uid;
      dbRef.doc(id).set({
        'id': id,
        'role': role,
        'name' : name,
        'email': email,
        'phone' : '',
        'image': '',
        'address': '',
        "isDeleted": false,
        'pass': password,
        'isVerified': "Not"
      });

      notify.getDeviceToken().then((value) {
        tokenRef.doc(auth.currentUser!.uid).set({
          'token':value.toString()
        });
        FirebaseMessaging.instance.onTokenRefresh.listen((value) {
          tokenRef.doc(auth.currentUser!.uid).set({
            'token': value.toString()
          });
        });
      });


      auth.currentUser!.updateDisplayName(name);
      RoleController().role = role;
      Get.to(CompleteProfile());



      Utils.toastMessage('User Created Successfully', Colors.green);

    }).onError((error, stackTrace){
      setLoading(false);
      print(error);
      Utils.toastMessage(error.toString(),Colors.red);
    });




  }







}
