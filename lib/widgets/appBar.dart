import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar appBar(context,text) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        text,
        style: GoogleFonts.kavoon(fontSize: 21),
      ),
      automaticallyImplyLeading: false,
      leading: InkWell(
        onTap: () => Navigator.of(context).pop(),
        child: const Center(
          child: FaIcon(
            FontAwesomeIcons.angleLeft,
          ),
        ),
      ),
    );
  }