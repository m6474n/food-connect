


import 'package:flutter/material.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/views/screens/donation/NGODonations.dart';
import 'package:food_donation_app/views/screens/welcome_screens/boarding_screen.dart';
import 'package:food_donation_app/views/screens/authentication/emailValidation.dart';
import 'package:food_donation_app/views/screens/dashboards/dashboard.dart';
import 'package:food_donation_app/views/screens/authentication/login.dart';
import 'package:food_donation_app/views/screens/authentication/register.dart';
import 'package:food_donation_app/views/screens/chat/ChatScreen.dart';
import 'package:food_donation_app/views/screens/chat/UsersListScreen.dart';
import 'package:food_donation_app/views/screens/donation/DonationScreen.dart';
import 'package:food_donation_app/views/screens/map/MapScreen.dart';
import 'package:food_donation_app/views/screens/profile/ProfileScreen.dart';
import 'package:food_donation_app/views/screens/donation/addDonation.dart';
import 'package:food_donation_app/views/screens/welcome_screens/splash_screen.dart';
import 'package:food_donation_app/views/screens/welcome_screens/welcome_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteName.loginScreen:
        return MaterialPageRoute(builder: (_) =>  LoginScreen());
      case RouteName.registerScreen:
        return MaterialPageRoute(builder: (_) =>  RegisterScreen());
      case RouteName.welcomScreen:
        return MaterialPageRoute(builder: (_) =>  WelcomeScreen());
      case RouteName.boardingScreen:
        return MaterialPageRoute(builder: (_) =>  BoardingScreen());
      case RouteName.dashboard:
        return MaterialPageRoute(builder: (_)=>  DashboardScreen());
      case RouteName.chatScreen:
        return MaterialPageRoute(builder: (_)=>  ChatScreen());
      case RouteName.mapScreen:
        return MaterialPageRoute(builder: (_)=>  MapScreen());
      case RouteName.donationScreen:
        return MaterialPageRoute(builder: (_)=>  DonationScreen());
      case RouteName.profileScreen:
        return MaterialPageRoute(builder: (_)=>  ProfileScreen());
      case RouteName.validationScreen:
        return MaterialPageRoute(builder: (_)=>  ValidationScreen());
      case RouteName.addDonation:
        return MaterialPageRoute(builder: (_)=>  AddDonation());
      case RouteName.ngoDonation:
        return MaterialPageRoute(builder: (_)=>  NGODonationScreen());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}

Map<String , WidgetBuilder> routes={
  "/" : (context) => DashboardScreen(),
  "/splashScreen" : (context) => SplashScreen(),
  "/login" : (context) => LoginScreen(),
  "/signup" : (context) => RegisterScreen(),
  "/boarding" : (context) => BoardingScreen(),
  "/welcome" : (context) => WelcomeScreen(),

};