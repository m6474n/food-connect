import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_donation_app/components/InputField.dart';
import 'package:food_donation_app/components/card.dart';
import 'package:food_donation_app/components/searchField.dart';
import 'package:food_donation_app/controller/LocationManager.dart';
import 'package:food_donation_app/controller/Role_manager.dart';
import 'package:food_donation_app/controller/Session_manager.dart';
import 'package:food_donation_app/controller/notification_services.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();
  final searchNode = FocusNode();
  final dbref = FirebaseFirestore.instance.collection("Users");
  String location = 'loading...';
  String profile =
      'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';
// NotificationServices _services = NotificationServices();
  void getUserData() async {
    var ref = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      location = ref['address'];
      profile = ref['image'];
    });
  }

  void initState() {
// _services.firebaseInit();
//     _services.requestNotificationServices();
//     _services.isTokenRefreshed();
//     _services.getDeviceToken().then((value) {
//       FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).update(
//           {
//             'token': value
//           });
//
//       print(value);
//     });

    // TODO: implement initState
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 1,
              backgroundColor: Colors.grey.shade100,
              title: Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ListTile(
                    leading: GestureDetector(
                        child: Icon(
                      Icons.location_on,
                      color: mainColor,
                      size: 32,
                    )),
                    title: Text(
                      LocationManager().local == null ? "Loading..." : location,
                      // location.toString(),
                      style: paragraph.copyWith(
                          fontSize: 12, color: mainColor, height: 1),
                    ),
                    trailing: profile == ''
                        ? Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade100),
                            height: 40,
                            width: 40,
                            child: Icon(Icons.person),
                          )
                        : CircleAvatar(
                            backgroundImage: NetworkImage(profile),
                          ),
                  ))),
          body: Column(
            children: [
              //
              // ),
              SizedBox(
                height: 20,
              ),
              CarouselSlider(
                  items: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(18),
                          image: const DecorationImage(
                            image: AssetImage(
                              './././asset/carousal_img_1.jpg',
                            ),
                            fit: BoxFit.cover,
                          )),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(18),
                          image: const DecorationImage(
                            image: AssetImage(
                              './././asset/carousal_img_2.jpg',
                            ),
                            fit: BoxFit.cover,
                          )),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(18),
                          image: const DecorationImage(
                            image: AssetImage(
                              './././asset/carousal_img_3.jpg',
                            ),
                            fit: BoxFit.cover,
                          )),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(18),
                          image: const DecorationImage(
                            image: AssetImage(
                              './././asset/carousal_img_4.jpg',
                            ),
                            fit: BoxFit.cover,
                          )),
                    ),
                  ],
                  options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 2.0,
                      enlargeCenterPage: true)),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 120,
                color: Colors.black87,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 60,

                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      child: Text('Recent Donations',
                          style:
                              paragraph.copyWith(fontWeight: FontWeight.bold)),
                    )),Expanded(
                        child: GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, RouteName.donationScreen);
                          },
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text('See all',
                                style: paragraph.copyWith(color: mainColor),),
                          ),
                        ))
                  ],
                ),
              ),

              Expanded(
                child: RoleController().role == 'Restaurant'
                    ? StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('donations')
                            .where('id',
                                isEqualTo:
                                    FirebaseAuth.instance.currentUser!.uid)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (!snapshot.hasData) {
                            return Center(child: Text('Something went wrong'));
                          }
                          if (snapshot.data.docs.isEmpty) {
                            return Center(
                                child: Text(
                              'No active donation available',
                              style: paragraph,
                            ));
                          }
                          return Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  return DonationCard(
                                    item: snapshot.data!.docs[index]['item'],
                                    quantity: snapshot.data!.docs[index]
                                        ['quantity'],
                                    restaurentName: snapshot.data!.docs[index]
                                        ['donated by'],
                                    time: snapshot.data!.docs[index]
                                                ['prep time'] ==
                                            null
                                        ? ""
                                        : snapshot.data!.docs[index]
                                            ['prep time'],
                                    address: snapshot.data.docs[index]
                                        ['location'],
                                    status: snapshot.data.docs[index]['status'],
                                    onTap: () {},
                                  );
                                }),
                          );
                        },
                      )
                    : StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('donations')
                            .where('status', isEqualTo: 'active')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                                child: CircularProgressIndicator(
                              color: mainColor,
                            ));
                          }
                          if (!snapshot.hasData) {
                            return Center(child: Text('Something went wrong'));
                          }
                          if (snapshot.data.docs.isEmpty) {
                            return Center(
                                child: Text(
                              'No active donation available',
                              style: paragraph,
                            ));
                          }
                          return Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: ListView.builder(
                                // scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  return DonationCard(
                                    item: snapshot.data!.docs[index]['item'],
                                    quantity: snapshot.data!.docs[index]
                                        ['quantity'],
                                    restaurentName: snapshot.data!.docs[index]
                                        ['donated by'],
                                    time: snapshot.data!.docs[index]
                                                ['prep time'] ==
                                            null
                                        ? ""
                                        : snapshot.data!.docs[index]
                                            ['prep time'],
                                    address: snapshot.data.docs[index]
                                        ['location'],
                                    status: snapshot.data.docs[index]['status'],
                                    onTap: () {},
                                  );
                                }),
                          );
                        },
                      ),
              )
            ],
          )),
    );
  }
}
