import 'package:flutter/material.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/utility/utils.dart';
import 'package:food_donation_app/views/screens/ChatScreen.dart';
import 'package:food_donation_app/views/screens/DonationScreen.dart';
import 'package:food_donation_app/views/screens/HomeScreen.dart';
import 'package:food_donation_app/views/screens/MapScreen.dart';
import 'package:food_donation_app/views/screens/ProfileScreen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _list = [
    HomeScreen(),
    MapScreen(),
    DonationScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      body: _list.elementAt(_selectedIndex),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18 ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: mainColor.withOpacity(0.1),
          ),
          child: GNav(
            gap: width * 0.01,
            tabBackgroundColor: mainColor.withOpacity(0.3),
            tabBackgroundGradient:
                LinearGradient(colors: [mainColor, secondaryColor]),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: mainColor,
            activeColor: Colors.white,
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
                textStyle:
                    paragraph.copyWith(color: Colors.white, fontSize: 16),
              ),
              GButton(
                icon: Icons.map,
                text: 'Map',
                textStyle:
                    paragraph.copyWith(color: Colors.white, fontSize: 16),
              ),
              GButton(
                icon: Icons.add,
                text: 'Add',
                textStyle:
                    paragraph.copyWith(color: Colors.white, fontSize: 16),
              ),
              GButton(
                icon: Icons.message,
                text: 'Message',
                textStyle:
                    paragraph.copyWith(color: Colors.white, fontSize: 16),
              ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
                textStyle:
                    paragraph.copyWith(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
