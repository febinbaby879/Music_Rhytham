import 'package:flutter/material.dart';
import 'package:moon_walker/widgets/snackbar.dart';
import '../../domain/Allsongs/model/allSongModel.dart';
import '../../infrastructure/dbfunc/favourite/fav_func.dart';




class favIcon extends StatefulWidget {
  Songs currentSong;
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
             SnackBaaaar(text: 'Removed from favorite', context: context);
            } else {
              widget.isfav=true;
              addFavourat(widget.currentSong);
              SnackBaaaar(text: 'Added to favourite', context: context,);
            }
          },
        );
      },
      child: (widget.isfav)
          ? const Icon(Icons.favorite_sharp,color: Colors.purple,)
          : const Icon(Icons.favorite_border),
    );
  }
}
