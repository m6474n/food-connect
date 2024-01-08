import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/components/card.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/utility/utils.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final userRef = FirebaseFirestore.instance.collection('Users');
  final donationRef = FirebaseFirestore.instance.collection('donations');
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Admin Dashboard',
            style: TextStyle(color: mainColor),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    Navigator.pushNamed(context, RouteName.loginScreen);
                    Utils.toastMessage('Logout!', Colors.red);
                  });
                },
                icon: Icon(Icons.logout))
          ],
          bottom: TabBar(
            labelColor: mainColor,
            labelStyle: paragraph,
            indicatorColor: mainColor,
            tabs: [
              Tab(
                child: Text('Users'),
              ),
              Tab(
                child: Text('Donations'),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              child: StreamBuilder(
                stream: userRef.snapshots(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text('Something went wrong...'),
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        if(snapshot.data.docs[index]['role'] == 'Admin'){
                          return Container();
                        }
                        return ListTile(
                          onTap: (){
                            snapshot.data.docs[index].delete();
                          },
                          leading: snapshot.data.docs[index]['image'] == ''
                              ? CircleAvatar(
                                  backgroundColor: Colors.grey.shade100,
                                )
                              : CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      snapshot.data.docs[index]['image']),
                                ),
                          title: Text(snapshot.data.docs[index]['name']),
                          subtitle: Text(snapshot.data.docs[index]['email']),
                          trailing: Text(snapshot.data.docs[index]['role'], style: paragraph.copyWith(fontSize: 14),),
                        );
                      });
                },
              ),
            ),
            Container(
              child: StreamBuilder(
                stream: donationRef.snapshots(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text('Something went wrong...'),
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        return CardContiner(
                          item: snapshot.data!.docs[index]['item'],
                          quantity: snapshot.data!.docs[index]['quantity'],
                          restaurentName: snapshot.data!.docs[index]
                          ['donated by'],
                          time: snapshot.data!.docs[index]['prep time'] ==
                              null
                              ? ""
                              : snapshot.data!.docs[index]['prep time'],
                          address: snapshot.data.docs[index]['location'],
                          status: snapshot.data.docs[index]['status'],
                          onTap: () {},
                        );
                      });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
