import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/components/GradientButton.dart';
import 'package:food_donation_app/components/RoundedButton.dart';
import 'package:food_donation_app/controller/Session_manager.dart';
import 'package:food_donation_app/controller/home_controller.dart';
import 'package:food_donation_app/controller/profile_controller.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/utility/utils.dart';
import 'package:food_donation_app/views/login.dart';
import 'package:food_donation_app/views/screens/profile/edit_profile.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final auth = FirebaseAuth.instance;

  String name = "Loading...";
  String email = "Loading...";
  String phone = "Loading...";
  String address = "Loading...";
  String role = 'Loading...';
// String? img ;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final provider = Provider.of<ProfileProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // title: Text(
        //   'Profile Screen',
        //   style: paragraph.copyWith(fontSize: 22, color: mainColor),
        // ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_)=> EditProfile(name: name, email: email, phone: phone, address: address)));
              },
              child: Text(
                'Edti Profile',
                style: paragraph.copyWith(color: mainColor),
              ))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                // bottom: 1,
                child: Container(
                  height: height * 0.8,
                ),
              ),
              Positioned(
                  bottom: 0,
                  child: Container(
                    height: height * 0.7,
                    width: width * 1,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade50.withOpacity(0.6),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24))),
                  )),

              StreamBuilder(stream: FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).snapshots(), builder: (context,snapshot){
               name = snapshot.data!['name'];
               email = snapshot.data!['email'];
               phone = snapshot.data!['phone'];
               address = snapshot.data!['address'];
               role = snapshot.data!['role'];

                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(color: mainColor,),);
                }
                else if(!snapshot.hasData){
                  return Center(child: Text('Something went wrong! Try again later.'),);
                }
                else{
                  return  Positioned(
                   top: 150
                    ,
                    child: Container(
                      width: width *1,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      height: height * 0.5,
                      child: ListView(
                        children: [
                          ReusableRow(title: 'Name', value: name, iconData: Icons.person)
                          , ReusableRow(title: 'Email', value: email, iconData: Icons.email)
                          ,ReusableRow(title: 'Phone', value: phone, iconData: Icons.phone)
                          ,ReusableRow(title: 'Address', value: address, iconData: Icons.home)
                          // ,ReusableRow(title: 'Address', value: 'Name', iconData: Icons.home)
                        ],
                      ),
                    ),
                  );
                }
              }),
               Positioned(
                  top: 0,
                  child: CircleAvatar(
                    radius: 72,
                    backgroundColor: mainColor,
                  )),
              Positioned(
                  bottom: 25,
                  child: Container(
                      padding: EdgeInsets.all(12),
                      height: 80,
                      width: width * 1,
                      child: GradientButton(
                          label: 'Logout',
                          onPress: () {
                           provider.logutUser(context);
                          },
                          loading: provider.Loading)))
            ],
          ),
        ],
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
            style: Theme.of(context).textTheme.bodyText2,
          ),
          leading: Icon(
            iconData,
            color: mainColor,
          ),
          trailing: Container(
            width: MediaQuery.of(context).size.width *0.5,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.right,
            ),
          ),
        ),
        Divider(
          thickness: 1,
          color: Colors.white,
        )
      ],
    );
  }
}
