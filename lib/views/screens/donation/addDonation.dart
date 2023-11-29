import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/components/GradientButton.dart';
import 'package:food_donation_app/components/InputField.dart';
import 'package:food_donation_app/components/donationField.dart';
import 'package:food_donation_app/controller/Session_manager.dart';
import 'package:food_donation_app/models/product_model.dart';
import 'package:food_donation_app/utility/constants.dart';

class AddDonation extends StatefulWidget {
  const AddDonation({super.key});

  @override
  State<AddDonation> createState() => _AddDonationState();
}

class _AddDonationState extends State<AddDonation> {
  final productController = TextEditingController();
  final qtyController = TextEditingController();
  final productNode = FocusNode();
  final qtyNode = FocusNode();
  final List _list = [];
  addProduct(value) {
    setState(() {
      _list.add(value);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    productController.dispose();
    qtyController.dispose();
    productNode.dispose();
    qtyNode.dispose();
  }

  final ref = FirebaseFirestore.instance.collection('donations');
  // final date = DateTime.now();
  TimeOfDay timeOfDay = TimeOfDay.now();
  DateTime dateRef = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final hours = timeOfDay.hour.toString().padLeft(2, '0');
    final minutes = timeOfDay.minute.toString().padLeft(2, '0');

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Add Donation',
            style: Heading1.copyWith(fontSize: 24),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              Container(
                child: Form(
                  key: _formKey,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: DonationField(
                            focusNode: productNode,
                            label: 'Item',
                            validator: (value) {
                              value.isEmpty ? "Enter Item" : null;
                            },
                            keyboardType: TextInputType.text,
                            controller: productController,
                          )),
                      Expanded(
                          flex: 2,
                          child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: DonationField(
                                  controller: qtyController,
                                  keyboardType: TextInputType.number,
                                  validator: (val) {
                                    val.isEmpty ? "Enter Quantity" : null;
                                  },
                                  focusNode: qtyNode,
                                  label: 'Quantity'))),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                           if(_formKey.currentState!.validate()){
                             final product = Products(
                                 timeOfDay.hour.toString()+":"+timeOfDay.minute.toString(), dateRef,
                                 item: productController.value.text,
                                 quantity: qtyController.value.text);
                             final user = product.toJson();
                             addProduct(user);
                             productController.clear();
                             print(user);
                             qtyController.clear();
                           }
                          },
                          child: Container(
                            height: 60,
                            width: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: GestureDetector(
                  onTap: () async {
                    final TimeOfDay? prepTime = await showTimePicker(
                        context: context, initialTime: timeOfDay);
                    if (prepTime != null) {
                      setState(() {
                        timeOfDay = prepTime;
                      });
                      return;
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        // border:Border.all(width: 1, color: mainColor)
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Prepration Time:',
                          style: paragraph.copyWith(color: mainColor),
                        ),
                        Text(
                          '${timeOfDay.hour}:${timeOfDay.minute}',
                          style:
                              paragraph.copyWith(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Added Items',
                    style: Heading3.copyWith(fontSize: 18, color: textColor),
                  )),
              Expanded(
                  child: ListView.builder(
                      itemCount: _list.length,

                      // itemCount: provider.list.length,
                      itemBuilder: (context, index) {
                        // final String? dateTimeRef = _list[index]['date'] +", "+ _list[index]['time'];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            onTap: () {
                              setState(() {
                                _list.removeAt(index);
                              });
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            tileColor: Colors.grey.withOpacity(0.1),
                            title: Text(
                              _list[index]['product'],
                              style: paragraph.copyWith(
                                  color: Colors.green, fontSize: 16),
                            ),
                            // subtitle: Text(dateTimeRef.toString()),
                            trailing: Text(_list[index]['quantity'],
                                style: paragraph.copyWith(fontSize: 16)),
                          ),
                        );
                      })),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: GradientButton(
                    label: 'Donate',
                    onPress: () {
                      ref
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .set({"donation": FieldValue.arrayUnion(_list)});
                    },
                    loading: false),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: dateRef,
      firstDate: DateTime(1900),
      lastDate: DateTime(2200));

  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: timeOfDay.hour, minute: timeOfDay.minute));
}
