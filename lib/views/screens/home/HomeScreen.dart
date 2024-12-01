import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:food_donation_app/Services/DestinationController.dart';
import 'package:food_donation_app/Services/SourceController.dart';
import 'package:food_donation_app/components/GradientButton.dart';
import 'package:food_donation_app/controller/donationController.dart';
import 'package:food_donation_app/utility/Language.dart';
import 'package:food_donation_app/views/screens/authentication/login.dart';
import 'package:food_donation_app/views/screens/donation/addDonation.dart';
import 'package:http/http.dart' as http;
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:food_donation_app/components/InputField.dart';
import 'package:food_donation_app/components/card.dart';
import 'package:food_donation_app/components/searchField.dart';
import 'package:food_donation_app/Services/LocationManager.dart';
import 'package:food_donation_app/Services/Role_manager.dart';
import 'package:food_donation_app/Services/Session_manager.dart';
import 'package:food_donation_app/controller/mappController.dart';
import 'package:food_donation_app/controller/notification_services.dart';
import 'package:food_donation_app/controller/routeController.dart';
import 'package:food_donation_app/main.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/views/screens/donation/DonationScreen.dart';
import 'package:food_donation_app/views/screens/donation/NGODonations.dart';
import 'package:food_donation_app/views/screens/donation/donationDetails.dart';
import 'package:get/get.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
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

  getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar(
          'Location permission disabled!', 'Turn on the location service');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Permission Denied', 'Turn on the location service');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Get.snackbar('Location permissions are permanently denied',
          'We can not request the permissions');
    }
    return await Geolocator.getCurrentPosition();
  }

  // MapController _controller = Get.put(MapController());
  NotificationServices notify = NotificationServices();
  final tokenRef = FirebaseFirestore.instance.collection('Devices');
  final auth = FirebaseAuth.instance;
  void initState() {
    notify.getDeviceToken().then((value) {
      tokenRef
          .doc(auth.currentUser!.uid)
          .set({'role': RoleController().role, 'token': value.toString()});
    });
    FirebaseMessaging.instance.onTokenRefresh.listen((value) {
      tokenRef
          .doc(auth.currentUser!.uid)
          .set({'role': RoleController().role, 'token': value.toString()});
    });

    // TODO: implement initState
    getUserData();

    getCurrentLocation().then((value) {
      SourceController().source = LatLng(value.latitude, value.longitude);
    });

    super.initState();


  }

  _changeLanguage(Language language) {
Get.updateLocale(Locale(language.languageCode));


  }

  final  donationController = Get.put(DonationController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                // setState(() {});
                // getCurrentLocation().then((value) {
                //   location = value.toString();
                // });
              },
              child: Icon(
                Icons.location_on,
                color: mainColor,
                size: 32,
              )),
          title: Text(
            location,
            // location.toString(),
            style: paragraph.copyWith(
                fontSize: 12, color: mainColor, height: 1),
          ) ,actions:  [
          // IconButton(onPressed: () {  }, icon: Icon(Icons.language,),),
          DropdownButton(
              underline: SizedBox(),
              icon: Icon(Icons.language),
              items: Language.languageList()
                  .map<DropdownMenuItem<Language>>(
                      (lang) => DropdownMenuItem(
                      value: lang,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(lang.flag,),
                          Text(lang.name, style: TextStyle(fontSize: 20))
                        ],
                      )))
                  .toList(),
              onChanged: (Language? language) {
                _changeLanguage(language!);
              }),SizedBox(width: 6,),
          profile == ''
              ? Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade100),
            height: 40,
            width: 40,
            child: Icon(
              Icons.person,
              color: mainColor,
              size: 32,
            ),
          )
              : CircleAvatar(
            backgroundImage: NetworkImage(profile),
          ),
          SizedBox(width: 18,)
        ],),
        body: Column(
          children: [
            //
            // ),
            SizedBox(
              height: 18,
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
                    autoPlay: true, aspectRatio: 2.0, enlargeCenterPage: true)),

            // Container(
            //   height: 120,
            //   color: Colors.black87,
            // ),

            RoleController().role == "Restaurant"?
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18,horizontal: 38.0),
              child: GradientButton(label: "Donate", onPress: (){
                Get.to(()=> AddDonation());
              }, loading: false),
            ):Container(),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text('recent_donations'.tr,
                    style: paragraph.copyWith(fontWeight: FontWeight.bold)),
                  ),
                  GestureDetector(
                    onTap: () {
                  RoleController().role == "Restaurant"
                      ? Get.to(DonationScreen())
                      : Get.to(NGODonationScreen());
                  ;
                  // FirebaseAuth.instance.signOut().then((value) => Get.to(LoginScreen()));
                    },
                    child: Container(
                  // alignment: Alignment.centerRight,
                  child: Text(
                    ">",
                    style: paragraph.copyWith(color: mainColor, fontSize: 32),
                  ),
                    ),
                  )
                ],
              ),
            ),

            Expanded(
              child: RoleController().role == 'Restaurant'
                  ? donationController.getDonations()
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
                          return Center(child: Text('something_went_wrong'.tr));
                        }
                        if (snapshot.data.docs.isEmpty) {
                          return Center(
                              child: Text(
                            'no_active_donation_available'.tr,
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
                                      : snapshot.data!.docs[index]['prep time'],

                                  status: snapshot.data.docs[index]['status'],
                                  onTap: () async {
                                    DestinationController().destination =
                                        LatLng(snapshot.data.docs[index]['lat'],
                                            snapshot.data.docs[index]['long']);

                                    print(SourceController().source);
                                    print(DestinationController().destination);

                                    Get.to(DonationDetails(
                                        item: snapshot.data.docs[index]['item'],
                                        type: snapshot.data.docs[index]['type'],
                                        serving: snapshot.data.docs[index]
                                            ['quantity'],
                                        time: snapshot.data.docs[index]
                                            ['prep time'],
                                        donerId: snapshot.data.docs[index]
                                            ['donor_Id'],
                                        donerName: snapshot.data.docs[index]
                                            ['donated by'], id: snapshot.data.docs[index].id,
                                    ));
                                  },
                                  type: snapshot.data!.docs[index]['type'],
                                );
                              }),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
