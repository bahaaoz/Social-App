import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar topAppBar() {
  return AppBar(
    elevation: 0,
    leading: IconButton(
      onPressed: () {},
      icon: const Icon(
        FontAwesomeIcons.comments,
      ),
    ),
    centerTitle: true,
    title: Text(
      "Social",
      style: GoogleFonts.lobster(
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
