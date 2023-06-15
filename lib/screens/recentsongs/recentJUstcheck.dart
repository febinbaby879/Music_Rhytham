import 'package:flutter/material.dart';
import 'package:moon_walker/database/Favourite/functions/fav_func.dart';
import 'package:moon_walker/database/Recent/recentDB/recentdb.dart';
import 'package:moon_walker/screens/commen_widgets/listtile_customwidgets.dart';
import 'package:moon_walker/screens/contatants/const.dart';
import 'package:moon_walker/screens/favaouriteScreen/fav_icon.dart';
import 'package:moon_walker/screens/fetchPermission/convert_audio.dart';
import 'package:moon_walker/screens/now_mini/mini_laast.dart';
import 'package:moon_walker/screens/playlist/add.dart';
import 'package:on_audio_query/on_audio_query.dart';


class RecentPage extends StatefulWidget {
  const RecentPage({super.key});

  @override
  State<RecentPage> createState() => _RecentPageState();
}

class _RecentPageState extends State<RecentPage> {
  void _clearRecentSongs() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear Recent Songs'),
          content:
              const Text('Are you sure you want to clear the recent songs?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  //recentSongsList.clear();
                });
                Navigator.pop(context);
              },
              child: const Text('Clear'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:const Text('Recent Songs'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(musicImages.instance.scaffBackImg),
              fit: BoxFit.cover,
              opacity: 240),
          gradient: LinearGradient(
              colors: ScafBack,
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
        physics:const BouncingScrollPhysics(),        
        itemBuilder: (context, index) {
          return Card(
            child: InkWell(
              onTap: () {
                AudioConvert(recentList.value, index);
                showBottomSheet(
                  context: context,
                  builder: ((context) => miniLast()),
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
                        musicImages.instance.queryImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  id: recentList.value[index].id!,
                  type: ArtworkType.AUDIO,
                ),
                title: Text(
                  recentList.value[index].songname??'unknown',
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
                          builder: (context) =>
                              AddToPlaylist(addToPlaylistSong: recentList.value[index]),
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
