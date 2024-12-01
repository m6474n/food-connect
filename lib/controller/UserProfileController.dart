import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/views/screens/profile/profile_screen.dart';
import 'package:get/get.dart';

class UserProfile extends GetxController {
  final userStream = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
  getUserDetails() {
    return StreamBuilder(
        stream: userStream,
        builder: (context, snapshot) {
          return Container(
            height: 160,
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(),
                    ListTile(
                      title: Text('Name'),
                      subtitle: Text('Email'),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.navigate_next),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }

   profileLayout(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(),
            ListTile(
              title: Text('Name'),
              subtitle: Text('Email'),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.navigate_next),
              ),
            )
          ],
        )
      ],
    );
  }
}
