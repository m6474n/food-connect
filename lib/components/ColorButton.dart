import 'package:flutter/material.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class ColorButton extends StatelessWidget {
  const ColorButton(
      {Key? key,
        required this.label,
        required this.color,

        required this.onPress,

        required this.loading})
      : super(key: key);
  final String label;
final Color color;
  final VoidCallback onPress;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ? null : onPress,
      child: Container(
        height: 50,
        // width: 250,
        width: double.infinity,
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: loading
                ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(color: Colors.white,),
            )
                : Text(
              label,
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            )),
      ),
    );
  }
}
