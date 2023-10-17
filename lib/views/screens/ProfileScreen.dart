import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/components/RoundedButton.dart';
import 'package:food_donation_app/routes/route_name.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(radius: 62,),
         SizedBox(height: 40,),


        RoundedButton(label: 'Logout', bgColor: Colors.red, onPress: () {
          auth.signOut().then((value) {
            Navigator.pushNamed(context, RouteName.loginScreen);
          });
        }, labelColor: Colors.white, loading: false,)
      ],),
    ),);
  }
}
