import 'package:flutter/material.dart';
import 'package:food_donation_app/utility/constants.dart';
class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
    cursorColor: mainColor,

        decoration: InputDecoration(
        filled: true,
suffixIcon: Icon(Icons.filter_list_outlined, color: mainColor,),
        contentPadding:EdgeInsets.symmetric(horizontal: 16,vertical: 12),
    hintStyle: paragraph,
    hintText: 'Search Something',

    border: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(12)))
    );}
}
