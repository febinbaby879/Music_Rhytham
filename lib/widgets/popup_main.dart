import 'package:flutter/material.dart';

class popupAllSongs extends StatelessWidget {
  const popupAllSongs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          // onTap: () {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (Context) => favouriteScreen(),
          //     ),
          //   );
          // },
          child: Row(
            children: [
              Icon(Icons.favorite_outline),
              SizedBox(
                width: 20,
              ),
              Text('Add to favourite'),
            ],
          ),
        ),
        PopupMenuItem(
          // onTap: () {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => playList(),
          //     ),
          //   );
          // },
          child: Row(
            children: [
              Icon(Icons.list),
              SizedBox(width: 20),
              Text('Add to playlist'),
            ],
          ),
        ),
      ],
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}