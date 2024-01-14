

import 'package:flutter/material.dart';
import 'package:food_donation_app/utility/constants.dart';

class SearchField extends StatelessWidget {
  SearchField({
    required this.controller,
    required this.label,

    Key? key, required this.onTap, this.onChanged,
  }) : super(key: key);

  TextEditingController controller = TextEditingController();

  IconData? icon;
  final String label;
  final VoidCallback onTap;
  final ValueChanged<String>? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,

      cursorColor: mainColor,

onChanged: onChanged,
      decoration: InputDecoration(

        fillColor: Colors.grey.shade100,
suffixIcon: GestureDetector(
    onTap: onTap,
    child: Icon(Icons.search)),
        hintStyle: paragraph.copyWith(color: mainColor),
        hintText: label,
        filled: true,
        contentPadding: EdgeInsets.all(18),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
      ),
    );
  }
}
