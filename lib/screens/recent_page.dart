import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moon_walker/widgets/listView.dart';

class RecentList extends StatelessWidget {
  const RecentList({super.key});

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
                      Text('Recent played',style: GoogleFonts.kavoon(fontSize: 18)),
                      Spacer(),
                      // IconButton(onPressed: (){}, icon: Icon(Icons.abc_sharp)),
                      // IconButton(onPressed: (){}, icon: Icon(Icons.search),)
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*.02,
                ),
                Expanded(child: LiistView(),),
              ],
            ),
          ),
        )
      ),
    );
  }
}
