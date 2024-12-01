import 'package:flutter/material.dart';

import 'package:food_donation_app/components/RoundedButton.dart';
import 'package:food_donation_app/components/SquareButton.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/views/screens/authentication/login.dart';
import 'package:food_donation_app/views/screens/authentication/register.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'welcome'.tr,
                style: Heading1,
              ),
              Text(
                'start_your_helping_journey'.tr,
                style: paragraph,
              ),
              SizedBox(
                height: 60,
              ),
              Image.asset(
                'asset/welcome.png',
              ),
              SizedBox(
                height: 80,
              ),
              RoundedButton(
                label: 'login'.tr,
                loading: false,
                bgColor: mainColor,
                onPress: () {
                  Get.to(LoginScreen());
                },
                labelColor: Colors.white,
              ),
              SizedBox(
                height: 18,
              ),
              RoundedButton(
                loading: false,
                label: 'register'.tr,
                bgColor: Colors.grey.shade400,
                onPress: () {

                  Get.to(RegisterScreen());
                },
                labelColor: Colors.white,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
