import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:food_donation_app/Services/LocationManager.dart';
import 'package:food_donation_app/Services/Role_manager.dart';
import 'package:food_donation_app/controller/notificationController.dart';
import 'package:food_donation_app/controller/notification_services.dart';
import 'package:food_donation_app/main.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/utility/utils.dart';
import 'package:food_donation_app/views/screens/chat/ChatScreen.dart';
import 'package:food_donation_app/views/screens/dashboards/admin/admin_dashboard.dart';
import 'package:food_donation_app/views/screens/dashboards/ngo_dashboard.dart';
import 'package:food_donation_app/views/screens/donation/DonationScreen.dart';
import 'package:food_donation_app/views/screens/Profile/ProfileScreen.dart';
import 'package:food_donation_app/views/screens/donation/NGODonations.dart';
import 'package:food_donation_app/views/screens/home/HomeScreen.dart';
import 'package:food_donation_app/views/screens/map/MapScreen.dart';
import 'package:food_donation_app/views/screens/profile/profile_screen.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  void getCred() {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        RoleController().role = value['role'];
        LocationManager().local = value['address'];
      });
    });
  }

  final List<Widget> _list = [
    HomeScreen(),
    MapScreen(),
    DonationScreen(),
    // Text('NGO'),
    // RoleController().role == 'NGO' ? NGODonationScreen():DonationScreen(),
    ChatScreen(),
    // TestScreen(),
    ProfileScreen(),
  ];

  int _selectedIndex = 0;
NotificationController cont = Get.put(NotificationController());
  @override
  void initState() {

    getCred();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: RoleController().role == 'Admin'
          ? AdminDashboard()
          : RoleController().role == 'NGO'
              ? NgoDashboard()
              : Scaffold(
                  body: _list.elementAt(_selectedIndex),
                  bottomNavigationBar: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: GNav(
                      gap: width * 0.01,
                      tabBackgroundColor: Colors.grey.shade200,
                      // tabBackgroundGradient:
                      //     LinearGradient(colors: [mainColor, secondaryColor]),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      color: mainColor,

                      activeColor: mainColor,

                      selectedIndex: _selectedIndex,
                      onTabChange: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      tabs: [
                        GButton(
                          iconActiveColor: mainColor,
                          icon: Icons.home,
                          text: 'home'.tr,
                          textStyle: paragraph.copyWith(
                              color: mainColor, fontSize: 16),
                        ),
                        GButton(
                          iconActiveColor: mainColor,
                          icon: Icons.map,
                          text: 'map'.tr,
                          textStyle: paragraph.copyWith(
                              color: mainColor, fontSize: 16),
                        ),
                        GButton(
                          iconActiveColor: mainColor,
                          icon: Icons.dataset,
                          text: 'donations'.tr,
                          textStyle: paragraph.copyWith(
                              color: mainColor, fontSize: 16),
                        ),
                        GButton(
                          iconActiveColor: mainColor,
                          icon: Icons.message,
                          text: 'message'.tr,
                          textStyle: paragraph.copyWith(
                              color: mainColor, fontSize: 16),
                        ),
                        GButton(
                          iconActiveColor: mainColor,
                          icon: Icons.person,
                          text: 'profile'.tr,
                          textStyle: paragraph.copyWith(
                              color: mainColor, fontSize: 16),
                        ),
                      ],
                    ),
                  ),

                ),
    );
  }
}
