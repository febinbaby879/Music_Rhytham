import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moon_walker/infrastructure/dbfunc/favourite/fav_func.dart';
import 'package:moon_walker/infrastructure/dbfunc/most/mostlyplayed.dart';
import 'package:moon_walker/widgets/appBar.dart';
import 'package:moon_walker/widgets/listtile_customwidgets.dart';
import 'package:moon_walker/core/contatants/const.dart';
import 'package:moon_walker/presentatation/favaouriteScreen/fav_icon.dart';
import 'package:moon_walker/presentatation/now_mini/mini_laast.dart';
import 'package:moon_walker/presentatation/playlist/add.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../infrastructure/functions/convertaudio.dart';


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
            image: AssetImage(MusicImages.instance.scaffBackImg),
            fit: BoxFit.cover,
            opacity: 230),
        gradient: LinearGradient(
          colors: scafBack,
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
                return (mostplay.value.isEmpty ? noSongs() : mostplaybuid());
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
              audioConvert(mostplay.value, index);
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
                  MusicImages.instance.queryImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            trailing1: favIcon(
              currentSong: mostplay.value[index],
              isfav: favarotList.value.contains(mostplay.value[index]),
            ),
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
              itemBuilder: (context) => const[
                PopupMenuItem(
                  value: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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

 Center  noSongs() {
   return const Center(
      child: Text('No SongList > 3'),
    );
  }
}
