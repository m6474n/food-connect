import 'package:flutter/material.dart';
import 'package:food_donation_app/components/card.dart';
import 'package:food_donation_app/components/searchField.dart';
import 'package:food_donation_app/utility/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor : Colors.white,
        elevation: 2,
        automaticallyImplyLeading: false,
        title: ListTile(
          leading: Icon(Icons.location_on_outlined),
          title: Text(
            'Your Location',
            style: Heading3.copyWith(height: 0.1),
          ),
          subtitle: Text(
            'Description',
            style: paragraph.copyWith(fontSize: 14, height: 0.2),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.notifications_outlined)),
          CircleAvatar(
            backgroundColor: mainColor,
            backgroundImage: AssetImage('./asset/profile.png'),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Container(
              child: SearchField(),
            ),
            Container(
              height: 200,
              margin: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                    image: AssetImage('./asset/homepage_banner.png'),
                    fit: BoxFit.cover),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.1, 1]),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 30,
                          width: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              gradient: LinearGradient(
                                  colors: [mainColor, secondaryColor])),
                          child: Center(
                              child: Text(
                            'Donate',
                            style: Heading3.copyWith(color: Colors.white),
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "NGO's near you",
                  style: Heading3.copyWith(color: Colors.grey),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'see all',
                      style: paragraph.copyWith(color: mainColor),
                    ))
              ],
            ),
            Expanded(child: Container(
              child: ListView.builder(itemBuilder: (context, index) {
                return CardContiner();
              }),
            ))
          ],
        ),
      ),
    );
  }
}
