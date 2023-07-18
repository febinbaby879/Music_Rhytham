
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_walker/application/favourite/favourite_bloc.dart';
import 'package:moon_walker/application/recentplayed/recentplayed_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../core/contatants/const.dart';
import '../../domain/Allsongs/model/allSongModel.dart';
import '../dbfunc/most/mostlyplayed.dart';
import '../dbfunc/recent/recentdb.dart';


List<Songs> allSongs = [];

Future<List<Songs>> songfetch(BuildContext context) async {
  List<SongModel> fetchsongs = await audioQuery.querySongs();
  for (SongModel element in fetchsongs) {
    if (element.fileExtension == "mp3") {
      allSongs.add(
        Songs(
          songname: element.displayNameWOExt,
          artist: element.artist,
          duration: element.duration,
          songurl: element.uri,
          id: element.id,
        ),
      );
    }
  }

  // ignore: use_build_context_synchronously
  context.read<FavouriteBloc>().add(FetchAllFAvourites());
  // ignore: use_build_context_synchronously
  context.read<RecentplayedBloc>().add(GetFecent());
  //await getFAvourite();
  //await getplayList();
  await mostplayedfetch();
  await recentfetchh();
  return allSongs;
}
