import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class newPlaylist extends StatelessWidget {
  const newPlaylist({super.key});

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
                        "Create playlist",
                        style: GoogleFonts.kavoon(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.08,),
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'List name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
                Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top:20.0),
                            child: Text('Create'),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
