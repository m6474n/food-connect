import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/components/searchField.dart';
import 'package:food_donation_app/Services/Chat_services.dart';
import 'package:food_donation_app/Services/Role_manager.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/views/screens/chat/ChatPage.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<ChatController>(context, listen: true);

    return Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false, title: Text(RoleController().role == "Restaurant"? "available_NGOs".tr:"available_restaurants".tr, style: paragraph.copyWith(fontSize: 24, color:mainColor),)),
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SearchField(
                  controller: _searchController,
                  label: 'search'.tr,
                  onTap: () {},
                  onChanged: (String value) {
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: RoleController().role == "Restaurant"
                    ? StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("Users")
                            .where("role", isEqualTo: "NGO")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (!snapshot.hasData) {
                            return Center(
                              child: Text('No Restaurant Available'),
                            );
                          }
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                if (_searchController.text.isEmpty) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      onTap: () {
                                        // provider.createChatRoom(FirebaseAuth.instance.currentUser!.uid, snapshot.data!.docs[index]['id']);
                                       Get.to(ChatPage(
                                                    receiverUserName: snapshot
                                                        .data!
                                                        .docs[index]['name'],
                                                    receiverUserId: snapshot
                                                        .data!
                                                        .docs[index]['id']));
                                      },
                                      leading: snapshot.data!.docs[index]
                                                  ['image'] ==
                                              ""
                                          ? CircleAvatar(
                                              child: Icon(
                                                Icons.person,
                                                color: Colors.orange,
                                              ),
                                              radius: 32,
                                            )
                                          : CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  snapshot.data!.docs[index]
                                                      ['image']),
                                              radius: 32,
                                            ),
                                      title: Text(
                                          snapshot.data!.docs[index]['name']),
                                    ),
                                  );
                                } else if (snapshot.data!.docs[index]['name']
                                    .toString()
                                    .toLowerCase()
                                    .contains(
                                        _searchController.text.toLowerCase())) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      onTap: () {
                                        // provider.createChatRoom(FirebaseAuth.instance.currentUser!.uid, snapshot.data!.docs[index]['id']);
                                      Get.to(ChatPage(
                                                    receiverUserName: snapshot
                                                        .data!
                                                        .docs[index]['name'],
                                                    receiverUserId: snapshot
                                                        .data!
                                                        .docs[index]['id']));
                                      },
                                      leading: snapshot.data!.docs[index]
                                                  ['image'] ==
                                              ""
                                          ? CircleAvatar(
                                              child: Icon(
                                                Icons.person,
                                                color: Colors.orange,
                                              ),
                                              radius: 32,
                                            )
                                          : CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  snapshot.data!.docs[index]
                                                      ['image']),
                                              radius: 32,
                                            ),
                                      title: Text(
                                          snapshot.data!.docs[index]['name']),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              });
                        })
                    : StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Users")
                        .where("role", isEqualTo: "Restaurant")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData) {
                        return Center(
                          child: Text('No Restaurant Available'),
                        );
                      }
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            if (_searchController.text.isEmpty) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  onTap: () {
                                    // provider.createChatRoom(FirebaseAuth.instance.currentUser!.uid, snapshot.data!.docs[index]['id']);
                                  Get.to( ChatPage(
                                                receiverUserName: snapshot
                                                    .data!
                                                    .docs[index]['name'],
                                                receiverUserId: snapshot
                                                    .data!
                                                    .docs[index]['id']));
                                  },
                                  leading: snapshot.data!.docs[index]
                                  ['image'] ==
                                      ""
                                      ? CircleAvatar(
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.orange,
                                    ),
                                    radius: 32,
                                  )
                                      : CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        snapshot.data!.docs[index]
                                        ['image']),
                                    radius: 32,
                                  ),
                                  title: Text(
                                      snapshot.data!.docs[index]['name']),
                                ),
                              );
                            } else if (snapshot.data!.docs[index]['name']
                                .toString()
                                .toLowerCase()
                                .contains(
                                _searchController.text.toLowerCase())) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  onTap: () {
                                    // provider.createChatRoom(FirebaseAuth.instance.currentUser!.uid, snapshot.data!.docs[index]['id']);
                                   Get.to(ChatPage(
                                                receiverUserName: snapshot
                                                    .data!
                                                    .docs[index]['name'],
                                                receiverUserId: snapshot
                                                    .data!
                                                    .docs[index]['id']));
                                  },
                                  leading: snapshot.data!.docs[index]
                                  ['image'] ==
                                      ""
                                      ? CircleAvatar(
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.orange,
                                    ),
                                    radius: 32,
                                  )
                                      : CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        snapshot.data!.docs[index]
                                        ['image']),
                                    radius: 32,
                                  ),
                                  title: Text(
                                      snapshot.data!.docs[index]['name']),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          });
                    }),
              )
            ],
          ),
        ));
  }
}
