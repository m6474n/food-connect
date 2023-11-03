


import 'package:flutter/material.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/views/boarding_screen.dart';
import 'package:food_donation_app/views/emailValidation.dart';
import 'package:food_donation_app/views/home_page.dart';
import 'package:food_donation_app/views/login.dart';
import 'package:food_donation_app/views/register.dart';
import 'package:food_donation_app/views/screens/ChatScreen.dart';
import 'package:food_donation_app/views/screens/DonationScreen.dart';
import 'package:food_donation_app/views/screens/MapScreen.dart';
import 'package:food_donation_app/views/screens/ProfileScreen.dart';
import 'package:food_donation_app/views/splash_screen.dart';
import 'package:food_donation_app/views/welcome_screen.dart';

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
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case RouteName.boardingScreen:
        return MaterialPageRoute(builder: (_) => const BoardingScreen());
      case RouteName.homeScreen:
        return MaterialPageRoute(builder: (_)=> const HomePage());
      case RouteName.chatScreen:
        return MaterialPageRoute(builder: (_)=> const ChatScreen());
      case RouteName.mapScreen:
        return MaterialPageRoute(builder: (_)=> const MapScreen());
      case RouteName.donationScreen:
        return MaterialPageRoute(builder: (_)=> const DonationScreen());
      case RouteName.profileScreen:
        return MaterialPageRoute(builder: (_)=> const ProfileScreen());
        case RouteName.validationScreen:
        return MaterialPageRoute(builder: (_)=> const ValidationScreen());


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
  "/" : (context) => HomePage(),
  "/splashScreen" : (context) => SplashScreen(),
  "/login" : (context) => LoginScreen(),
  "/signup" : (context) => RegisterScreen(),
  "/boarding" : (context) => BoardingScreen(),
  "/welcome" : (context) => WelcomeScreen(),

};