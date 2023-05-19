import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moon_walker/widgets/listView.dart';

class favouriteScreen extends StatelessWidget {
  const favouriteScreen({super.key});

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
                      Text('Favourites',style: GoogleFonts.kavoon(fontSize: 18)),
                      Spacer(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(child: LiistView(),)
              ],
            ),
          ),
        )
      ),
    );
  }
}
