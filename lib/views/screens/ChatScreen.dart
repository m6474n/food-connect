import 'package:flutter/material.dart';
import 'package:food_donation_app/components/searchField.dart';
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
        child: Column(children: [
          SearchField(),
          SizedBox(height: 60,),
          Card(child: ListTile(leading: CircleAvatar(),title: Text('Name'),subtitle: Text('Message'),)),
          Card(child: ListTile(leading: CircleAvatar(),title: Text('Name'),subtitle: Text('Message'),))
          ,

        ],),
      ),),
    );
  }
}
