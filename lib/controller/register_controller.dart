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
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref('Users');

  void setLoading (bool value){
    _isLoading = value;
    notifyListeners();

  }


  void signup(BuildContext context, String name,String email,String password){
      setLoading(true);
    auth.createUserWithEmailAndPassword(email: email, password: password).then((value){
      setLoading(false);
      Navigator.pushNamed(context, RouteName.homeScreen);

      databaseRef.child(value.user!.uid.toString()).set({
        'id': value.user!.uid.toString(),
        'name': name,
        'email': email,
        'password': password,
        'image': ''


      });


      Utils.toastMessage('User Created Successfully', Colors.green);

    }).onError((error, stackTrace){
      setLoading(false);
      print(error);
      Utils.toastMessage(error.toString(),Colors.red);
    });




  }




}
