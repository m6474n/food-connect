import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/controller/login_controller.dart';
import 'package:food_donation_app/controller/register_controller.dart';
import 'package:food_donation_app/models/list_Provider.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/routes/routes.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/views/add_post.dart';
import 'package:food_donation_app/views/emailValidation.dart';
import 'package:food_donation_app/views/screens/test_screen.dart';

import 'package:food_donation_app/views/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=> LoginProvider()),
      ChangeNotifierProvider(create: (_)=> RegisterProvider()),
      ChangeNotifierProvider(create: (_)=> ListProvider()),

      // ChangeNotifierProvider(create: create)

    ],child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ).copyWith(primaryColor: mainColor),
     // home: TestScreen(),
      home: SplashScreen(),
      initialRoute: RouteName.splashScreen,
      onGenerateRoute: Routes.generateRoute,
    ),);
  }
}
