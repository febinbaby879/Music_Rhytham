import 'package:flutter/material.dart';
import 'package:moon_walker/infrastructure/dbfunc/favourite/fav_func.dart';
import 'package:moon_walker/widgets/listtile_customwidgets.dart';
import 'package:moon_walker/core/contatants/const.dart';
import 'package:moon_walker/presentatation/favaouriteScreen/fav_icon.dart';
import 'package:moon_walker/presentatation/now_mini/mini_laast.dart';
import 'package:moon_walker/presentatation/playlist/add.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../infrastructure/dbfunc/recent/recentdb.dart';
import '../../infrastructure/functions/convertaudio.dart';

class RecentPage extends StatefulWidget {
  const RecentPage({super.key});

  @override
  State<RecentPage> createState() => _RecentPageState();
}

class _RecentPageState extends State<RecentPage> {
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
        child: recentListView(),
      ),
    );
  }

  Widget recentListView() {
    if (recentList.value.isEmpty) {
      return const Center(
        child: Text(
          'No Recent Items',
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Card(
            child: InkWell(
              onTap: () {
                audioConvert(recentList.value, index);
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
                  id: recentList.value[index].id!,
                  type: ArtworkType.AUDIO,
                ),
                title: Text(
                  recentList.value[index].songname ?? 'unknown',
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(recentList.value[index].artist ?? 'No artist'),
                trailing1: favIcon(
                  currentSong: recentList.value[index],
                  isfav: favarotList.value.contains(recentList.value[index]),
                ),
                trailing2: PopupMenuButton(
                  iconSize: 30,
                  onSelected: (value) {
                    if (value == 0) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddToPlaylist(
                              addToPlaylistSong: recentList.value[index]),
                        ),
                      );
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
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: recentList.value.length,
      ),
    );
  }
}
