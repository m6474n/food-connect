import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/utility/utils.dart';
import 'package:food_donation_app/views/home_page.dart';



class LoginProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final FirebaseAuth auth = FirebaseAuth.instance;
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void Login(BuildContext context, String email, String password) {
    setLoading(true);
    auth
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
          setLoading(false);
          Utils.toastMessage("Login Successfully", Colors.green);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }).catchError((e) {
      Utils.toastMessage(e.toString(), Colors.green);
    }).whenComplete(() {
      setLoading(false);
    });
  }
}
