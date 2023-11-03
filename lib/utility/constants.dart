import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color mainColor = Color(0xfff15a29);
const Color textColor = Color(0xff939393);
const Color secondaryColor = Color(0xffbe1e2d);

TextStyle Heading1 = GoogleFonts.openSans(
    fontSize: 40, fontWeight: FontWeight.bold, color: mainColor, height: 1);
TextStyle Heading2 = GoogleFonts.openSans(
    fontWeight: FontWeight.w600, color: mainColor, fontSize: 36);
TextStyle Heading3 = GoogleFonts.openSans(
    fontWeight: FontWeight.w500, color: mainColor, fontSize: 16);
TextStyle paragraph = GoogleFonts.openSans(
    fontSize: 16, fontWeight: FontWeight.w400, color: textColor);
