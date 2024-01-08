import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/controller/LocationController.dart';
import 'package:food_donation_app/controller/Role_manager.dart';
import 'package:food_donation_app/controller/chatroomController.dart';
import 'package:food_donation_app/controller/donationController.dart';
import 'package:food_donation_app/controller/firebase_api.dart';
import 'package:food_donation_app/controller/login_controller.dart';
import 'package:food_donation_app/controller/notification_services.dart';
import 'package:food_donation_app/controller/profile_controller.dart';
import 'package:food_donation_app/controller/register_controller.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/routes/routes.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/views/screens/authentication/emailValidation.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:food_donation_app/l10n/l10n.dart';
import 'package:food_donation_app/views/screens/map/donationMap.dart';
import 'package:food_donation_app/views/screens/welcome_screens/splash_screen.dart';
import 'package:intl/intl_standalone.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await findSystemLocale();
  // FirebaseApi().initNotifications();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  NotificationServices().firebaseInit();
  NotificationServices().requestNotificationServices();
  NotificationServices().isTokenRefreshed();

  runApp(const MyApp());
}
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message)async{

  await Firebase.initializeApp();
  print(message.notification!.title.toString());

}


class MyApp extends StatelessWidget {
  const MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=> LoginProvider()),
      ChangeNotifierProvider(create: (_)=> RegisterProvider()),
      ChangeNotifierProvider(create: (_)=> LocationController()),
      ChangeNotifierProvider(create: (_)=> ProfileProvider()),
      ChangeNotifierProvider(create: (_)=> ChatRoomController()),
      ChangeNotifierProvider(create: (_)=> DonationController()),

      // ChangeNotifierProvider(create: create)

    ],child: MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Locale('en'),
      localizationsDelegates: [
        AppLocalizations.delegate,
          // GlobalMaterialLocalization.delegate,

      ],
      supportedLocales: [
        const Locale('en'),const Locale('ur')
      ],
      title: 'Food Connect',
      theme: ThemeData(
        indicatorColor: mainColor,
        primarySwatch: primaryMaterialColor,
        useMaterial3: true,
      ),
     // home: TestScreen(),
      home: DonationMap(),
      // initialRoute: RouteName.splashScreen,
      // onGenerateRoute: Routes.generateRoute,
    ),);
  }
}
