import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_donation_app/Services/LocationManager.dart';
import 'package:food_donation_app/Services/Role_manager.dart';
import 'package:food_donation_app/controller/notification_services.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/utility/utils.dart';
import 'package:food_donation_app/views/screens/chat/ChatScreen.dart';
import 'package:food_donation_app/views/screens/dashboards/admin/admin_dashboard.dart';
import 'package:food_donation_app/views/screens/donation/DonationScreen.dart';
import 'package:food_donation_app/views/screens/Profile/ProfileScreen.dart';
import 'package:food_donation_app/views/screens/donation/NGODonations.dart';
import 'package:food_donation_app/views/screens/home/HomeScreen.dart';
import 'package:food_donation_app/views/screens/map/MapScreen.dart';
import 'package:food_donation_app/views/screens/profile/profile_screen.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NgoDashboard extends StatefulWidget {
  const NgoDashboard({Key? key}) : super(key: key);

  @override
  State<NgoDashboard> createState() => _NgoDashboardState();
}

class _NgoDashboardState extends State<NgoDashboard> {
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
    NGODonationScreen(),
    ChatScreen(),
    // Center(child: Text('NGO')),
// TestScreen(),
    ProfileScreen()
  ];

  int _selectedIndex = 0;
  NotificationServices _services = NotificationServices();


  @override
  void initState() {
    // TODO: implement initState

    NotificationServices().getDeviceToken().then((value) {
      FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).update(
          {
            'token': value
          });

      print(value);
    });


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
      child:  Scaffold(
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
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                text: 'Home',
                textStyle:
                paragraph.copyWith(color: mainColor, fontSize: 16),
              ),
              GButton(
                iconActiveColor: mainColor,
                icon: Icons.map,
                text: 'Map',
                textStyle:
                paragraph.copyWith(color: mainColor, fontSize: 16),
              ),
              GButton(
                iconActiveColor: mainColor,
                icon: Icons.dataset,
                text: 'Donations',
                textStyle:
                paragraph.copyWith(color: mainColor, fontSize: 16),
              ),
              GButton(
                iconActiveColor: mainColor,
                icon: Icons.message,
                text: 'Message',
                textStyle:
                paragraph.copyWith(color: mainColor, fontSize: 16),
              ),
              GButton(
                iconActiveColor: mainColor,
                icon: Icons.person,
                text: 'Profile',
                textStyle:
                paragraph.copyWith(color: mainColor, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
