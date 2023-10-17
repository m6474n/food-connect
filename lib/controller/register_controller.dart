import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/utility/utils.dart';
import 'package:food_donation_app/views/home_page.dart';

class RegisterProvider with ChangeNotifier{

  FirebaseAuth auth  = FirebaseAuth.instance;
   bool _isLoading = false;
  bool get isLoading => _isLoading;
 final dbRef = FirebaseFirestore.instance.collection('Users');
  void setLoading (bool value){
    _isLoading = value;
    notifyListeners();

  }


  void signup(BuildContext context, String name,String email,String password){
      setLoading(true);


    auth.createUserWithEmailAndPassword(email: email, password: password).then((value){
      setLoading(false);
      // final user =  auth.currentUser
      final id = DateTime.now().millisecondsSinceEpoch.toString();
      dbRef.doc(id).set({
        'id': id,
        'profile': '',
        'name': name,
        'email':email,
        'password': password.toString(),
        'location': '',
        'phone': ''
      });

      Navigator.pushNamed(context, RouteName.homeScreen);



      Utils.toastMessage('User Created Successfully', Colors.green);

    }).onError((error, stackTrace){
      setLoading(false);
      print(error);
      Utils.toastMessage(error.toString(),Colors.red);
    });




  }




}
