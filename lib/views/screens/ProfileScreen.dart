import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/components/GradientButton.dart';
import 'package:food_donation_app/components/RoundedButton.dart';
import 'package:food_donation_app/controller/Session_manager.dart';
import 'package:food_donation_app/controller/home_controller.dart';
import 'package:food_donation_app/controller/profile_controller.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/utility/utils.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final auth = FirebaseAuth.instance;
  // final dbRef = FirebaseFirestore.instance.collection('Users').snapshots();

  String name = "Loading...";
  String email = "Loading...";
  String phone = "Loading...";
  String address = "Loading...";
// String? img ;
 void getData()async{
  User? user = await FirebaseAuth.instance.currentUser;
   var userRef = FirebaseFirestore.instance.collection('Users').doc(user!.uid);
   var responseBody = await userRef.get();
setState(() {
  name = responseBody.data()!['name'];
  email = responseBody.data()!['email'];
  phone = responseBody.data()!['phone'];
  address = responseBody.data()!['address'];
  // img = responseBody.data()!['image'];
});
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   final provider = Provider.of<ProfileProvider>(context, listen: true);
    return SafeArea(
      child: Scaffold(
          body: Center(
        child: Column(
          children: [
            Spacer(),
            Stack(
              children: [
                CircleAvatar(
                  radius: 52,
                  // child: img != null? Image(image: NetworkImage('$img'),):Icon(Icons.person)
                ),
                Positioned(
                  top: 70,
                  left: 70,
                  child: GestureDetector(
                    onTap: (){
                     provider.pickImage(context);
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: mainColor),
                      child: Center(
                          child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 15,
                        ),
                      )),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
             Padding(
               padding: const EdgeInsets.all(24.0),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   data(content: name, label: 'Name'),
                   data(content:email, label: 'Email'),
                   data(content: phone, label: 'Phone'),
                   data(content: address, label: 'Address'),
                 ],
               ),
             )
                ,
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: GradientButton(
                  label: 'Logout',
                  onPress: () {
                    auth.signOut().then((value) {
                      Navigator.pushNamed(context, RouteName.loginScreen);
                    });
                  },
                  loading: false),



  )]))),
    );}
}

class data extends StatelessWidget {
  const data({super.key, required this.content, required this.label});
  final String label;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
        child: Column(
          children: [
            Container(height: 60,child: Row(children: [Expanded(
                flex: 1,
                child: Text(label,
          style: paragraph.copyWith(color: Colors.black),)),Expanded(
              flex: 2,
              child:
    Text(
            content,
            style: paragraph.copyWith(color: Colors.black),textAlign: TextAlign.right,
          ),
            )],),),

            Divider(
              height: 2,
              color: Colors.grey.withOpacity(0.2),
            )
          ],
        ));
  }
}
