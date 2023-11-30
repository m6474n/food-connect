import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/components/searchField.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/utility/utils.dart';
import 'package:food_donation_app/views/add_post.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var dbref = FirebaseFirestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Chat Screen',
          style: paragraph.copyWith(color: mainColor, fontSize: 22),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: SearchField(),
          ),
          StreamBuilder(
              stream: dbref.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  print('something went wrong');
                }
                return Expanded(
                  child: ListView.builder(
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        var document = snapshot.data!.docs[index];
                        return ListTile(
                          leading: CircleAvatar(),
                          title: Text(snapshot.data!.docs[index]['name']),
                          subtitle: Text(snapshot.data!.docs[index]['email']),
                        );
                      }),
                );
              })
        ],
      ),
      floatingActionButton: FloatingActionButton( onPressed: (){
        Navigator.pushNamed(context, RouteName.createChat);

      },child: Icon(Icons.add, color: Colors.white,),backgroundColor: mainColor,),
    );
  }
}
