import 'package:flutter/material.dart';
import 'package:moon_walker/database/Allsongs/model/allSongModel.dart';
import 'package:moon_walker/database/Favourite/functions/fav_func.dart';


class favIcon extends StatefulWidget {
  SongsAll currentSong;
  bool isfav;
  favIcon({super.key, required this.currentSong, required this.isfav});

  @override
  State<favIcon> createState() => _favIconState();
}

class _favIconState extends State<favIcon> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(
          () {
            if (widget.isfav) {
              widget.isfav = false;
             removeFavourite(widget.currentSong);
            } else {
              addFavourat(widget.currentSong);
              widget.isfav=true;
            }
          },
        );
      },
      child: (widget.isfav)
          ? Icon(Icons.favorite_sharp)
          : Icon(Icons.favorite_border),
    );
  }
}
