import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_donation_app/components/InputField.dart';
import 'package:food_donation_app/components/card.dart';
import 'package:food_donation_app/components/searchField.dart';
import 'package:food_donation_app/controller/Session_manager.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/views/add_post.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String position = "";

  final searchController = TextEditingController();
  final searchNode = FocusNode();
  final dbref = FirebaseFirestore.instance.collection("Users");
  String location = "Your location...";

  Future getLocation() async {
    var ref = await dbref.doc(FirebaseAuth.instance.currentUser!.uid).get();
    setState(() {
      location = ref.data()!['address'];

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 1,
              backgroundColor: mainColor,
              title: Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ListTile(
                    leading: GestureDetector(
                        onTap: getLocation,
                        child: Icon(Icons.location_on, color: Colors.white,size: 32,)),
                    title: Text(
                      location.toString(),
                      style: paragraph.copyWith(
                          fontSize: 12, color: Colors.white, height: 1),
                    ),

                    trailing: CircleAvatar(),
                  ))),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: InputField(
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    validator: (val) {
                      return null;
                    },
                    focusNode: searchNode,
                    icon: Icons.search,
                    label: 'Search Anything...'),
              ),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.grey.shade100),
              ),
              ListTile(
                title: Text(
                  'Recent Donations',
                  style: paragraph.copyWith(fontWeight: FontWeight.bold),
                ),
                trailing: GestureDetector(
                  onTap: (){

                  },
                  child: Text(
                    'See all',
                    style: paragraph.copyWith(color: mainColor),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  // itemCount: 1,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 24),
                          child: Container(
                            color: Colors.grey.shade50,
                            child: Row(
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                Expanded(
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.symmetric(horizontal: 18.0),
                                      child: Container(
                                        height: 80,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Food Title',
                                              style: Heading3.copyWith(fontSize: 18),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text("Restaurent Name"),
                                            Row(
                                              children: [
                                                Text('time'),
                                                SizedBox(
                                                  width: 40,
                                                ),
                                                Text('qty/person')
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ));
                    }),
              )
            ],
          )),
    );
  }
}
