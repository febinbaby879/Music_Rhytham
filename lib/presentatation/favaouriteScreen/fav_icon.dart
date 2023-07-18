import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_walker/application/favourite/favourite_bloc.dart';
import 'package:moon_walker/infrastructure/dbfunc/favourite/fav_func.dart';
import 'package:moon_walker/widgets/snackbar.dart';
import '../../domain/Allsongs/model/allSongModel.dart';

class favIcon extends StatelessWidget {
  Songs currentSong;
  bool isfav;
  favIcon({super.key, required this.currentSong, required this.isfav});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteBloc, FavouriteState>(
      builder: (context, state) {
        return InkWell(
          onTap: () async {
            if (isfav) {
              isfav = false;
              List<Songs> returnList = await removeFavourite(currentSong);
              BlocProvider.of<FavouriteBloc>(context).add(
                GetFavourite(favouriteList: returnList),
              );
              //context.read<FavouriteBloc>().add(GetFavourite(favouriteList: returnList));
              SnackBaaaar(text: 'Removed From favourite', context: context);
              print('${state.favouriteList.length}');
              print('${returnList.length}');
            } else {
              isfav = true;
              List<Songs> returnList = await addFavourat(currentSong);
              BlocProvider.of<FavouriteBloc>(context).add(
                GetFavourite(favouriteList: returnList),
              );
              SnackBaaaar(text: 'Added to Favourite', context: context);
              print('${state.favouriteList.length}');
              print('returnls${returnList.length}');
            }
            // setState(
            //   () {
            //     if (widget.isfav) {
            //       widget.isfav = false;
            //      removeFavourite(widget.currentSong);
            //      SnackBaaaar(text: 'Removed from favorite', context: context);
            //     } else {
            //       widget.isfav=true;
            //       addFavourat(widget.currentSong);
            //       SnackBaaaar(text: 'Added to favourite', context: context,);
            //     }
            //   },
            // );
          },
          child: (isfav)
              ? const Icon(
                  Icons.favorite_sharp,
                  color: Colors.purple,
                )
              : const Icon(Icons.favorite_border),
        );
      },
    );
  }
}
