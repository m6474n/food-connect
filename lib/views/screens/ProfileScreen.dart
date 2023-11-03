import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/components/GradientButton.dart';
import 'package:food_donation_app/components/RoundedButton.dart';
import 'package:food_donation_app/controller/Session_manager.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/utility/utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final auth = FirebaseAuth.instance;
  final dbRef = FirebaseFirestore.instance.collection('Users').snapshots();
  late final String _username, _email, _phone, _address, _pic, _isVerified;

  Future getUserData() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(auth.currentUser!.uid)
        .get()
        .then((value) {
      _username = value.data()!['name'].toString();
      _email = value.data()!['email'].toString();
      _phone = value.data()!['phone'].toString();
      _address = value.data()!['address'].toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(

        children: [
          Spacer(),
          Stack(
            children: [
              CircleAvatar(radius: 52,)
              ,Positioned(
                top: 70,
                left: 70,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: mainColor
                ),
                child: Center(child: IconButton(onPressed: (){}, icon: Icon(Icons.add, color: Colors.white,size: 15,),)),
                ),
              )
            ],
          ),
SizedBox(height: 20,),
      StreamBuilder(stream: FirebaseFirestore.instance.collection('Users').doc(auth.currentUser!.uid).snapshots(), builder: (context, AsyncSnapshot snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return CircularProgressIndicator( color: mainColor,);
        }
        if(snapshot.hasError){
          Utils.toastMessage("Something went wrong! Try again later. ", Colors.green);
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              data(content: snapshot.data['name'], label: 'Name'),
              data(content: snapshot.data['email'], label: 'Email'),
              data(content: snapshot.data['phone'], label: 'Phone'),
              data(content: snapshot.data['address'], label: 'Address'),

            ],
          ),
        );

      }),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: GradientButton(label: 'Logout', onPress: (){
              auth.signOut().then((value){Navigator.pushNamed(context, RouteName.loginScreen);
              });
            }, loading: false),
          )
        ],
      ),
    ));
  }
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
            ListTile(
              title: Text(
                label,
                style: paragraph.copyWith(color: Colors.black),
              ),
              trailing: Text(
                content,
                style: paragraph.copyWith(color: Colors.black),
              ),
            ),
            Divider(
              height: 2,
              color: Colors.grey.withOpacity(0.2),
            )
          ],
        ));
  }
}
