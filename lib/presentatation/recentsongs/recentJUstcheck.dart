import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_walker/application/favourite/favourite_bloc.dart';
import 'package:moon_walker/application/recentplayed/recentplayed_bloc.dart';
import 'package:moon_walker/domain/Allsongs/model/allSongModel.dart';
import 'package:moon_walker/widgets/listtile_customwidgets.dart';
import 'package:moon_walker/core/contatants/const.dart';
import 'package:moon_walker/presentatation/favaouriteScreen/fav_icon.dart';
import 'package:moon_walker/presentatation/now_mini/mini_laast.dart';
import 'package:moon_walker/presentatation/playlist/add.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../infrastructure/dbfunc/recent/recentdb.dart';
import '../../infrastructure/functions/convertaudio.dart';

List<Songs> recentlist = [];

class RecentPage extends StatelessWidget {
  const RecentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Recent Songs'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(MusicImages.instance.scaffBackImg),
                fit: BoxFit.cover,
                opacity: 240),
            gradient: LinearGradient(
                colors: scafBack,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: BlocBuilder<RecentplayedBloc, RecentplayedState>(
            builder: (context, state) {
              return (state.recentPlayed.isNotEmpty)
                  ? listview(state)
                  : embtySong();
            },
          )),
    );
  }

  Center embtySong() {
    return const Center(
      child: Text(
        'No Recent Items',
      ),
    );
  }
}

ListView listview(RecentplayedState state) {
  return ListView.builder(
    physics: const BouncingScrollPhysics(),
    itemBuilder: (context, index) {
      return Card(
        child: InkWell(
          onTap: () {
            audioConvert(state.recentPlayed, index);
            showBottomSheet(
              context: context,
              builder: ((context) {
                return miniLast();
              }),
            );
          },
          child: listTileWidget(
            index: index,
            context: context,
            leading: QueryArtworkWidget(
              nullArtworkWidget: SizedBox(
                width: 50,
                height: 50,
                child: ClipOval(
                  child: Image.asset(
                    MusicImages.instance.queryImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              id: state.recentPlayed[index].id!,
              type: ArtworkType.AUDIO,
            ),
            title: Text(
              state.recentPlayed[index].songname ?? 'unknown',
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(state.recentPlayed[index].artist ?? 'No artist'),
            trailing1: BlocBuilder<FavouriteBloc, FavouriteState>(
              builder: (context, favstate) {
                return favIcon(
                  currentSong: state.recentPlayed[index],
                  isfav: favstate.favouriteList.contains(
                    state.recentPlayed[index],
                  ),
                );
              },
            ),
            trailing2: PopupMenuButton(
              iconSize: 30,
              onSelected: (value) async{
                if (value == 0) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddToPlaylist(
                          addToPlaylistSong: state.recentPlayed[index]),
                    ),
                  );
                }
                if(value==1){
                  List<Songs> returnrecentlist=await recentremove(state.recentPlayed[index]);
                  context.read<RecentplayedBloc>().add(FetchRecent(recentlist: returnrecentlist));
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              shadowColor: Colors.brown,
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.playlist_add),
                      Text('Add to Playlist'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.remove),
                      Text('Remove'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
    itemCount: state.recentPlayed.length,
  );
}
