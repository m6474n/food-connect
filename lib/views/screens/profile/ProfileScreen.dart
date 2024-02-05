import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/components/GradientButton.dart';
import 'package:food_donation_app/components/RoundedButton.dart';
import 'package:food_donation_app/Services/Session_manager.dart';
import 'package:food_donation_app/controller/profile_controller.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/utility/utils.dart';
import 'package:food_donation_app/views/screens/authentication/login.dart';
import 'package:food_donation_app/views/screens/profile/complete_profile.dart';
import 'package:food_donation_app/views/screens/profile/edit_profile.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final auth = FirebaseAuth.instance;

  @override
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileProvider>(context, listen: true);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(auth.currentUser!.uid)
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {

            if (snapshot.connectionState == ConnectionState) {
              return Center(child: CircularProgressIndicator(color: mainColor,));
            }
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator(color: mainColor,));
            }
            if(snapshot.hasError){
              return Center(child: Text('Something went wrong'));
            }
            // DocumentSnapshot data = snapshot.data!;
            //
            // Map<String, dynamic> document = data.data() as Map<String, dynamic>;

            return ListView(
              children: [
                Container(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                      onTap: () {
                     Get.to(EditProfile(
                                    name: snapshot.data!['name'],
                                    email: snapshot.data!['email'],
                                    phone: snapshot.data!['phone'],
                                    address: snapshot.data!['address'], image: snapshot.data!['image'],));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          'edit_profile'.tr,
                          style: paragraph,
                          textAlign: TextAlign.right,
                        ),
                      )),
                ),
//
//
                Center(
                    child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey.shade100),
                  child:snapshot.data!['image'] == ""
                      ? Icon(Icons.person, size: 48,color: mainColor,)
                      : Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                  image: NetworkImage(
                               snapshot.data!['image']
                              ))),
                        ),
                )),
                SizedBox(
                  height: 30,
                ),
                ReusableRow(
                    title: 'name'.tr,
                    value: snapshot.data!['name'],
                    iconData: Icons.person),
                ReusableRow(
                    title: 'email'.tr,
                    value: snapshot.data!['email'],
                    iconData: Icons.mail),
                ReusableRow(
                    title: 'phone'.tr,
                    value: snapshot.data!['phone'],
                    iconData: Icons.phone),
                ReusableRow(
                    title: 'address'.tr,
                    value: snapshot.data!['address'],
                    iconData: Icons.home),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: GradientButton(
                      label: 'logout'.tr,
                      onPress: () {
                        auth.signOut().then((value) {
                       Get.back();
                       Get.to(LoginScreen());
                        });
                      },
                      loading: false),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title, value;
  final IconData iconData;

  const ReusableRow(
      {Key? key,
      required this.title,
      required this.value,
      required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: paragraph.copyWith(fontSize: 18 ),

          ),
          leading: Icon(
            iconData,
            color: mainColor,
          ),
          trailing: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(
              value,
              style: paragraph,
              textAlign: TextAlign.right,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Divider(
            color: Colors.grey.shade200,
          ),
        )
      ],
    );
  }
}
