import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/components/GradientButton.dart';
import 'package:food_donation_app/components/InputField.dart';
import 'package:food_donation_app/components/passwordField.dart';
import 'package:food_donation_app/controller/login_controller.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/routes/routes.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/utility/utils.dart';
import 'package:food_donation_app/views/screens/authentication/register.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({super.key});

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final emailNode = FocusNode();
  final passNode = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    emailNode.dispose();
    passNode.dispose();

    // TODO: implement dispose
    super.dispose();
  }


  //
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context, listen:  true);
    final mq = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Forget Password',
                  style: Heading1.copyWith(color: mainColor),
                ),
                SizedBox(height: 8,),
                Text(
                  'Enter your email to reset password',
                  style: paragraph,
                ),
                const SizedBox(
                  height: 40,
                ),
                Form(
                  key: _formKey,
                  child: Center(
                    child: Column(
                      children: [
                        InputField(
                          label: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          focusNode: emailNode,
                          icon: Icons.mail,
                          validator: (value) {
                            return value.isEmpty ? 'Enter Email' : null;
                          },
                        ),

                        const SizedBox(
                          height: 16,
                        ),

                        //


                        const SizedBox(
                          height: 32,
                        ),
                        GradientButton(
                            label: 'Reset',
                            onPress: () {
                              if (_formKey.currentState!.validate()) {
                                 provider.login(context, emailController.text, passController.text);
                              }
                            },
                            loading: provider.isLoading)
                      ],
                    ),


                  ),),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
