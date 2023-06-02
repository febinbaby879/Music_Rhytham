import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MostPlayed extends StatelessWidget {
  const MostPlayed({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Text(
                      'Most played',
                      style: GoogleFonts.kavoon(fontSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
