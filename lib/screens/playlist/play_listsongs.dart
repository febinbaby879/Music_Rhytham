import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class playListSongs extends StatelessWidget {
  const playListSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.arrow_back),
                      ),
                      Text(
                        'Play list one',
                        style: GoogleFonts.kavoon(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.02,
                ),
                // Expanded(
                //   child: LiistView(),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
