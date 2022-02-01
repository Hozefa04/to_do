import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {

  static TextStyle primaryRegular = GoogleFonts.ubuntu(
    fontSize: 22.0,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  static TextStyle primaryBold = GoogleFonts.ubuntu(
    fontSize: 22.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle heading = GoogleFonts.ubuntu(
    fontSize: 26.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle notesHeading = GoogleFonts.ubuntu(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle notesSummary = GoogleFonts.ubuntu(
    fontSize: 14.0,
    color: Colors.white,
  );

  static TextStyle notesDate = GoogleFonts.ubuntu(
    fontSize: 8.0,
    color: Colors.white,
  );

}