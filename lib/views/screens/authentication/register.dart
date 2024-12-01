import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/components/GradientButton.dart';
import 'package:food_donation_app/components/InputField.dart';
import 'package:food_donation_app/components/RoundedButton.dart';
import 'package:food_donation_app/components/passwordField.dart';
import 'package:food_donation_app/controller/register_controller.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:get/get.dart';
import 'package:food_donation_app/utility/utils.dart';
import 'package:food_donation_app/views/screens/authentication/login.dart';
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


  String? dropdownValue ;

  late  bool _passVisible = false;
  ValueNotifier<bool> toggle = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegisterProvider>(context, listen: true);
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
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
                    "sign_up".tr,
                    style: Heading1.copyWith(height: 1.3),
                  ),
                ),
                Center(
                  child: Text(
                    "create_your_account".tr,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 18.0),
                          child: Container(
                            height: 65,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey.shade200
                            ),
                            child: Row(children: [Expanded(child: Padding(
                                padding: const EdgeInsets.only(left: 14.0),

                                child: Row(children: [
                                  Icon(Icons.business, color:Colors.black87,),SizedBox(width: 12,)
                                  , Text('are_you:'.tr,style: paragraph.copyWith(fontSize: 18, color: mainColor,),),
                                ])
                            ),),Expanded(child:
                            Center(
                              child: DropdownButton<String>(
                                value: dropdownValue,

                                items:const [
                                  DropdownMenuItem<String>(
                                      value: 'Restaurant',
                                      child: Text('Restaurant', style:TextStyle(fontSize: 18, color: textColor))),
                                  DropdownMenuItem<String>(
                                      value: 'NGO',
                                      child: Text('NGO', style:TextStyle(fontSize: 18, color: textColor)))
                                ],
                                onChanged: (String? newValue){
                                  setState(() {
                                    dropdownValue = newValue!;
                                  });
                                },),
                            ),
                            )],),
                            //
                          ),
                        ),
                        InputField(
                          label: 'full_name'.tr,
                          keyboardType: TextInputType.text,
                          controller: nameController,
                          focusNode: nameNode,
                          icon: Icons.person,
                          validator: (value) {
                            return value.isEmpty ? 'enter_name'.tr : null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
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
                        SizedBox(
                          height: 20,
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
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // PasswordField(
                        //
                        //   obscure: true
                        //   ,
                        //   controller: passController,
                        //   focusNode: passNode,
                        //   validator: (value) {
                        //     return value.isEmpty ? 'Enter Password' : null;
                        //   },
                        //   label: 'Confirm Password',
                        //   keyboardType: TextInputType.visiblePassword,
                        //   icon: Icons.lock,
                        // ),
                        SizedBox(
                          height: 40,
                        ),
                        GradientButton(
                          loading: provider.isLoading,
                          label: 'create_account'.tr,
                          onPress: () {
                            if(_formKey.currentState!.validate()){
                              provider.signup(
                                  context,
                                  nameController.text,
                                  emailController.text,
                                  passController.text
                                  ,dropdownValue.toString()
                              );
                            }
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
                      "already_have_an_account?".tr,
                      style: paragraph,
                    ),
                    TextButton(
                        onPressed: () {
                         Get.to(LoginScreen());
                        },
                        child: Text(
                          "login".tr,
                          style: paragraph.copyWith(color: mainColor),
                        ))
                  ],
                )
              ],
            ),

          )),
    );
  }
}
