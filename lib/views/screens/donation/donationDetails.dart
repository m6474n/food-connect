import 'package:flutter/material.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/views/screens/map/donationMap.dart';

class DonationDetails extends StatefulWidget {
  const DonationDetails({super.key});

  @override
  State<DonationDetails> createState() => _DonationDetailsState();
}
class _DonationDetailsState extends State<DonationDetails> {
 ValueNotifier<bool> value = ValueNotifier<bool>(true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Donation Details')),
        body: Container(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('./././asset/food.jpg'),
                            fit: BoxFit.cover)),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.transparent, Colors.black54],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 150),
                // padding: EdgeInsets.all(32),
                child: Container(
                  padding: EdgeInsets.all(32),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32)),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
  ReusableRow(title: 'Item:', text: '',),
                     
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Description: ',
                                style: paragraph.copyWith(
                                    color: Colors.black87, fontSize: 16)),
                            Text('                                      '
                                ' '
                                '                       '
                                '                         '
                                '                          '
                                '                         '
                                ''),
                            SizedBox(height: 30,),
                            Container(
                              height: 50,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex:2,
                                    child: GestureDetector(
                                      onTap: (){
                                       // popUp(context);
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> DonationMap()));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(12)),
                                        child: Center(child: Text('Get Donation', style: paragraph.copyWith(color: Colors.black87, fontSize: 18),)),
                                      ),
                                    ),
                                  )
                                  ,SizedBox(width: 30,)
                                  ,Expanded(
                                    flex: 1,
                                    child: Container(
                                      decoration: BoxDecoration(color: mainColor, borderRadius: BorderRadius.circular(12)),
                                      child: Center(child: Text('Chat',style:paragraph.copyWith(color: Colors.white, fontSize: 18))),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
class ReusableRow extends StatelessWidget {
  final String title, text;
  const ReusableRow({super.key, required this.title, required this.text, });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: paragraph.copyWith(
                  color: Colors.black87, fontSize: 16),
            ),)),
          Expanded(child: Container(
            alignment: Alignment.centerRight,
            child: Text(text,style: paragraph.copyWith(
                color: Colors.black87, fontSize: 16),),)),
        ],
      ),
    );
  }
}

Future<void> popUp(BuildContext context){
  return showDialog(context: context, builder: (context){
    return AlertDialog(
      content: Container(
        height: 500,
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.white),
      ),
    );
  });

}
