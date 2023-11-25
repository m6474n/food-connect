import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/utility/utils.dart';
import 'package:food_donation_app/views/add_post.dart';
import 'package:food_donation_app/views/screens/ChatScreen.dart';
import 'package:food_donation_app/views/screens/DonationScreen.dart';
import 'package:food_donation_app/views/screens/HomeScreen.dart';
import 'package:food_donation_app/views/screens/MapScreen.dart';
import 'package:food_donation_app/views/screens/ProfileScreen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // final List<Widget> _list = [
  //   HomeScreen(),
  //   MapScreen(),
  //   DonationScreen(),
  //   ChatScreen(),
  //   ProfileScreen(),
  // ];

  int _selectedIndex = 0;
  final controller = PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreen() {
    return [
      // HomeScreen(),
      // MapScreen(),
      // DonationScreen(),
      // ChatScreen(),
      // ProfileScreen(),
      SafeArea(child: Center(child: Text('Home'))),
      SafeArea(child: Center(child: Text('map'))),
      SafeArea(child: Center(child: Text('add donation'))),
      SafeArea(child: Center(child: Text('chat'))),
      SafeArea(
          child: Center(
              child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.welcomScreen);
                  },
                  child: Text('profile')))),
    ];
  }

  List<PersistentBottomNavBarItem> _navbarItem() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.home,
          color: mainColor,
          size: 28,
        ),
        activeColorPrimary: mainColor.withOpacity(0.2),
        activeColorSecondary: mainColor,
        title: 'Home',
        textStyle: paragraph.copyWith(
            color: mainColor.withOpacity(1), fontWeight: FontWeight.bold),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.map,
          color: mainColor,
          size: 28,
        ),
        activeColorPrimary: mainColor.withOpacity(0.2),
        activeColorSecondary: mainColor,
        title: 'Map',
        textStyle: paragraph.copyWith(fontWeight: FontWeight.bold),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.add,
          color: mainColor,
          size: 28,
        ),
        activeColorPrimary: mainColor.withOpacity(0.2),
        activeColorSecondary: mainColor,
        title: 'Add',
        textStyle: paragraph.copyWith(fontWeight: FontWeight.bold),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.chat,
          color: mainColor,
          size: 28,
        ),
        activeColorPrimary: mainColor.withOpacity(0.2),
        activeColorSecondary: mainColor,
        title: 'Chat',
        textStyle: paragraph.copyWith(fontWeight: FontWeight.bold),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.person,
          color: mainColor,
          size: 28,
        ),
        activeColorPrimary: mainColor.withOpacity(0.2),
        activeColorSecondary: mainColor,
        title: 'Profile',
        textStyle: paragraph.copyWith(fontWeight: FontWeight.bold),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
   return CupertinoTabScaffold(

       tabBar: CupertinoTabBar(
         height: height*0.07,
         items: <BottomNavigationBarItem>[
     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home', activeIcon: Icon(Icons.home, color: mainColor,)),
     BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map',activeIcon: Icon(Icons.map, color: mainColor,)),
     BottomNavigationBarItem(icon: Icon(Icons.add),label: 'Donate',activeIcon: Icon(Icons.add, color: mainColor,)),
     BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat',activeIcon: Icon(Icons.chat, color: mainColor,)),
     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile',activeIcon: Icon(Icons.person, color: mainColor,)),
   ],), tabBuilder: (context,index){
     switch (index){
       case 0:
         return CupertinoTabView(builder: (context){
  return CupertinoPageScaffold(child: HomeScreen());
         },);
       case 1:
         return CupertinoTabView(builder: (context){
           return CupertinoPageScaffold(child: MapScreen());
         });
       case 2:
         return CupertinoTabView(builder: (context){
           return CupertinoPageScaffold(child: DonationScreen());
         });
       case 3:
         return CupertinoTabView(builder: (context){
           return CupertinoPageScaffold(child: ChatScreen());
         });
       case 4:
         return CupertinoTabView(builder: (context){
           return CupertinoPageScaffold(child: ProfileScreen());
         });

     }
     return Container();
   });
    // return Scaffold(
    //
    //   body: _list.elementAt(_selectedIndex),u
    //   bottomNavigationBar: Padding(
    //     padding: const EdgeInsets.all(18.0),
    //     child: Container(
    //       padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18 ),
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(30),
    //         color: mainColor.withOpacity(0.1),
    //       ),
    //       child: GNav(
    //         gap: width * 0.01,
    //         tabBackgroundColor: mainColor.withOpacity(0.3),
    //         tabBackgroundGradient:
    //             LinearGradient(colors: [mainColor, secondaryColor]),
    //         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    //         color: mainColor,
    //         activeColor: Colors.white,
    //         selectedIndex: _selectedIndex,
    //         onTabChange: (index) {
    //           setState(() {
    //             _selectedIndex = index;
    //           });
    //         },
    //         tabs: [
    //           GButton(
    //             icon: Icons.home,
    //             text: 'Home',
    //             textStyle:
    //                 paragraph.copyWith(color: Colors.white, fontSize: 16),
    //           ),
    //           GButton(
    //             icon: Icons.map,
    //             text: 'Map',
    //             textStyle:
    //                 paragraph.copyWith(color: Colors.white, fontSize: 16),
    //           ),
    //           GButton(
    //             icon: Icons.add,
    //             text: 'Add',
    //             textStyle:
    //                 paragraph.copyWith(color: Colors.white, fontSize: 16),
    //           ),
    //           GButton(
    //             icon: Icons.message,
    //             text: 'Message',
    //             textStyle:
    //                 paragraph.copyWith(color: Colors.white, fontSize: 16),
    //           ),
    //           GButton(
    //             icon: Icons.person,
    //             text: 'Profile',
    //             textStyle:
    //                 paragraph.copyWith(color: Colors.white, fontSize: 16),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
