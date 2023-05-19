import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget renamePlayList(BuildContext context) {
  return Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.arrow_back),
                      ),
                      Text(
                        'Rename play list',
                        style: GoogleFonts.kavoon(fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*.08,),
                  Card(
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(21),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        hintText: 'Rename playlist'
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
                            child: Text('Save'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
