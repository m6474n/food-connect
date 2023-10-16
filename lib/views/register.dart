import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/components/GradientButton.dart';
import 'package:food_donation_app/components/InputField.dart';
import 'package:food_donation_app/components/RoundedButton.dart';
import 'package:food_donation_app/components/passwordField.dart';
import 'package:food_donation_app/controller/register_controller.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/utility/utils.dart';
import 'package:food_donation_app/views/login.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();
  final nameNode = FocusNode();
  final emailNode = FocusNode();
  final passNode = FocusNode();
  final confirmPassNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    nameNode.dispose();
    emailController.dispose();
    emailNode.dispose();
    passController.dispose();
    passNode.dispose();
    confirmPassController.dispose();
    confirmPassNode.dispose();

    // TODO: implement dispose
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(18.0),
              child:ChangeNotifierProvider(create: (_)=>RegisterProvider(),
              child: Consumer<RegisterProvider>(builder: (context,value,child){
                return
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Container(
                      //   height: 200,
                      //   child: Image.asset('asset/signup.png'),
                      // ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      SizedBox(
                        height: 100,
                      ),
                      Center(
                        child: Text(
                          "Sign Up",
                          style: Heading1.copyWith(height: 1.3),
                        ),
                      ),
                      Center(
                        child: Text(
                          "Create your account",
                          style: paragraph,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              InputField(
                                label: 'Full Name',
                                keyboardType: TextInputType.text,
                                controller: nameController,
                                focusNode: nameNode,
                                icon: Icons.mail,
                                validator: (value) {
                                  return value.isEmpty ? 'Enter Name' : null;
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
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
                              SizedBox(
                                height: 20,
                              ),
                              PasswordField(
                                controller: passController,
                                focusNode: passNode,
                                validator: (value) {
                                  return value.isEmpty ? 'Enter Password' : null;
                                },
                                label: 'Password',
                                keyboardType: TextInputType.visiblePassword,
                                icon: Icons.lock,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              PasswordField(
                                controller: confirmPassController,
                                focusNode: confirmPassNode,
                                validator: (value) {
                                  return value.isEmpty ? 'Enter Password' : null;
                                },
                                label: 'Password',
                                keyboardType: TextInputType.visiblePassword,
                                icon: Icons.lock,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              GradientButton(
                                loading: isLoading,
                                label: 'Create Account',
                                onPress: () {
                                 value.signup(context,nameController.text, emailController.text, passController.text);
                                },
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: paragraph,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, RouteName.loginScreen);
                              },
                              child: Text(
                                "Login.",
                                style: paragraph.copyWith(color: mainColor),
                              ))
                        ],
                      )
                    ],
                  );
              },),)

          )),
    );
  }
}
