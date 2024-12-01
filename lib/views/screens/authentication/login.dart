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
import 'package:food_donation_app/views/screens/authentication/forget_pass.dart';
import 'package:food_donation_app/views/screens/authentication/register.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
ValueNotifier<bool> toggle = ValueNotifier<bool>(true);
late  bool _passVisible = false;

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
                Image.asset(
                  'asset/logo.png',
                  height: 100,
                ),
                const SizedBox(
                  height: 18,
                ),
                Text(
                  'welcome_back'.tr+"!",
                  style: Heading1.copyWith(color: mainColor),
                ),
                Text(
                  'login_to_your_account'.tr,
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
                                label: 'email'.tr,
                                keyboardType: TextInputType.emailAddress,
                                controller: emailController,
                                focusNode: emailNode,
                                icon: Icons.mail,
                                validator: (value) {
                                  return value.isEmpty ? 'enter_email'.tr : null;
                                },
                              ),

                                const SizedBox(
                                  height: 16,
                                ),
                                PasswordField(
                                  
                              
                                  controller: passController,
                                  focusNode: passNode,
                                  validator: (value) {
                                    return value.isEmpty
                                        ? 'enter_password'.tr
                                        : null;
                                  },
                                  label: 'password'.tr,
                                  keyboardType: TextInputType.visiblePassword,
                                 
                                ),
                                //
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                      onPressed: () {
                                       Get.to(ForgetPassScreen());
                                      },
                                      child: Text(
                                        "forget_password".tr,
                                        style: paragraph.copyWith(
                                            color: mainColor),
                                      )),
                                ),

                                const SizedBox(
                                  height: 32,
                                ),
                                GradientButton(
                                    label: 'login'.tr,
                                    onPress: () {
                                      if (_formKey.currentState!.validate()) {
                                        provider.login(context, emailController.text, passController.text);
                                        // return provider.Login(
                                        //     context,
                                        //     emailController.text,
                                        //     passController.text);
                                      }
                                    },
                                    loading: provider.isLoading)
                              ],
                            ),

                // ChangeNotifierProvider(
                //   create: (_) => LoginProvider(),
                //   child: Consumer<LoginProvider>(
                //     builder: (context, value, child) {
                //       return Form(
                //           key: _formKey,
                //           child: Center(
                //             child: Column(
                //               children: [
                //                 InputField(
                //                   label: 'Email',
                //                   keyboardType: TextInputType.emailAddress,
                //                   controller: emailController,
                //                   focusNode: emailNode,
                //                   icon: Icons.mail,
                //                   validator: (value) {
                //                     return value.isEmpty ? 'Enter Email' : null;
                //                   },
                //                 ),
                //
                //                 const SizedBox(
                //                   height: 16,
                //                 ),
                //                 PasswordField(
                //                   ontap: (){
                //                     setState(() {
                //                       _passVisible = !_passVisible;
                //                     });
                //                   },
                //                   obscure: _passVisible,
                //                   controller: passController,
                //                   focusNode: passNode,
                //                   validator: (value) {
                //                     return value.isEmpty
                //                         ? 'Enter Password'
                //                         : null;
                //                   },
                //                   label: 'Password',
                //                   keyboardType: TextInputType.visiblePassword,
                //                   icon: Icons.lock, visibility: toggle == true ? Icons.visibility_off : Icons.visibility,
                //                 ),
                //                 //
                //                 Align(
                //                   alignment: Alignment.centerRight,
                //                   child: TextButton(
                //                       onPressed: () {
                //                         Navigator.pushNamed(
                //                             context, RouteName.loginScreen);
                //                       },
                //                       child: Text(
                //                         "Forget Password ?",
                //                         style: paragraph.copyWith(
                //                             color: mainColor),
                //                       )),
                //                 ),
                //
                //                 const SizedBox(
                //                   height: 32,
                //                 ),
                //                 GradientButton(
                //                     label: 'Login',
                //                     onPress: () {
                //                       if (_formKey.currentState!.validate()) {
                //                         return value.Login(
                //                             context,
                //                             emailController.text,
                //                             passController.text);
                //                       }
                //                     },
                //                     loading: value.isLoading)
                //               ],
                //             ),
                //           ));
                //     },
                //   ),
                // ),
                        ),),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "don't_have_an_account?".tr,
                        style: paragraph,
                      ),
                      TextButton(
                          onPressed: () {
                    Get.to(RegisterScreen());
                    },
                          child: Text(
                            "register".tr,
                            style: paragraph.copyWith(color: mainColor),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
