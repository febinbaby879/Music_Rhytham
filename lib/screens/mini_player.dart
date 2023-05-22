
import 'package:flutter/material.dart';


void showBottomSheetFunction({
  required BuildContext context,
}) {
  showBottomSheet(
    context: context,
    builder: (ctx) {
      return Container(
        color: Color.fromARGB(255, 196, 196, 196),
        height: MediaQuery.of(context).size.height * .07,
        width: MediaQuery.of(context).size.width,
        child: ListTile(
          leading: Image.asset(
          'assets/images/7053026-silhouette-music-men-play-a-guitar-with-color-ink-splat-background-illustration-more-background.jpg'),
          title: Text('Song name'),
          subtitle: Text('Subtitle'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(onTap: () {
                
              },
              child: Icon(Icons.play_arrow),),
              InkWell(
                onTap: () {
                  
                },
              child: Icon(Icons.play_arrow),),
              InkWell(onTap: () {
                
              },
              child: Icon(Icons.play_arrow),),
            ],
          ),
        ),
      );
    },
  );
}
