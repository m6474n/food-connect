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
import 'package:food_donation_app/views/login.dart';
import 'package:food_donation_app/views/screens/profile/edit_profile.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final auth = FirebaseAuth.instance;

  String name = "Loading...";
  String email = "Loading...";
  String phone = "Loading...";
  String address = "Loading...";
  String role = 'Loading...';
// String? img ;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final provider = Provider.of<ProfileProvider>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: true,
        body: Container(
          height: height*0.9,
          child: Column(
            children: [
              SizedBox(height: 30,),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Users')
                      .doc(auth.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    // Map<String, dynamic>?  map = snapshot.data!.data();
                    name = snapshot.data!['name'].toString();
                    email = snapshot.data!['email'].toString();
                    phone = snapshot.data!['phone'].toString();
                    address = snapshot.data!['address'].toString();
                    role = snapshot.data!['role'].toString();
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Container(
                          height: 100,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: mainColor,
                            ),
                          ),
                        ),
                      );
                    }
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text(
                            'Something went wrong... Please Try again later.'),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 60,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => EditProfile(
                                            name: name,
                                            email: email,
                                            phone: phone,
                                            address: address)));
                              },
                              child: Text(
                                'Edit Profile',
                                style: paragraph.copyWith(color: mainColor),
                              )),
                          SizedBox(
                            height: 10,
                          ),

                          // data(content: role, label: 'Role'),
                          data(content: snapshot.data!['name'], label: 'Name'),
                          data(
                              content: snapshot.data!['email'], label: 'Email'),
                          data(
                              content: snapshot.data!['phone'] == ""
                                  ? "xxx xxxx xxxx"
                                  : phone,
                              label: 'Phone'),
                          data(
                              content: snapshot.data!['address'],
                              label: 'Address'),
                        ],
                      ),
                    );
                  }),
         SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: GradientButton(
                    label: 'Logout',
                    onPress: () {
                      auth.signOut().then((value) {
                        Navigator.pop(context);
                      });
                    },
                    loading: false),
              ),
            ],
          ),
        ),
      ),
    );
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
            Container(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: ClipRect(
                        child: Text(
                          label,
                          style: paragraph.copyWith(color: Colors.black),
                        ),
                      )),
                  Expanded(
                    flex: 2,
                    child: ClipRect(
                      child: Text(
                        content,
                        style: paragraph.copyWith(color: Colors.black),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  )
                ],
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
