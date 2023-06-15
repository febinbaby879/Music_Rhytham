import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moon_walker/database/most/mostlyplayed.dart';
import 'package:moon_walker/screens/commen_widgets/appBar.dart';
import 'package:moon_walker/screens/commen_widgets/listtile_customwidgets.dart';
import 'package:moon_walker/screens/contatants/const.dart';
import 'package:moon_walker/screens/fetchPermission/convert_audio.dart';
import 'package:moon_walker/screens/now_mini/mini_laast.dart';
import 'package:moon_walker/screens/playlist/add.dart';
import 'package:on_audio_query/on_audio_query.dart';

class mostplayed extends StatelessWidget {
  const mostplayed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar(       
      context, 'Most Played'),
      body: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(musicImages.instance.scaffBackImg),
            fit: BoxFit.cover,
            opacity: 230),
        gradient: LinearGradient(
          colors: ScafBack,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
        child: Padding(
          padding: const EdgeInsets.only(left:9.0,right: 9),
          child: SafeArea(
            child: ValueListenableBuilder(
              valueListenable: mostplay,
              builder: (context, value, _) {
                return (mostplay.value.isEmpty ? NOsongs() : mostplaybuid());
              },
            ),
          ),
        ),
      ),
    );
  }

  ListView mostplaybuid() {
    return ListView.builder(
      physics:const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
              AudioConvert(mostplay.value, index);
              showBottomSheet(
                context: context,
                builder: ((context) => miniLast()),
              );
            },
          child: listTileWidget(
            index: index,
            context: context,
            title: Text(
              mostplay.value[index].songname!,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              mostplay.value[index].artist ?? 'unknown',
            ),
            leading: QueryArtworkWidget(
              artworkFit: BoxFit.cover,
              id: mostplay.value[index].id!,
              type: ArtworkType.AUDIO,
              nullArtworkWidget: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  musicImages.instance.queryImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // trailing1: favIcon(
            //   currentSong: mostplay.value[index],
            //   isfav: favarotList.value.contains(allSongs[index]),
            // ),
            trailing2: PopupMenuButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onSelected: (value) {
                if (value == 0) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => AddToPlaylist(
                        addToPlaylistSong: mostplay.value[index],
                      ),
                    ),
                  );
                }
              },
              icon: const FaIcon(
                FontAwesomeIcons.ellipsisVertical,
                size: 26,
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(
                        Icons.playlist_add,
                      ),
                      Text(
                        'Add to playlist',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: mostplay.value.length,
    );
  }

 Center NOsongs() {
   return Center(
      child: Text('No most played songs'),
    );
  }
}
