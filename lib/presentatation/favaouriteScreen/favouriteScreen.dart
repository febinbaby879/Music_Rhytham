import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moon_walker/infrastructure/dbfunc/favourite/fav_func.dart';
import 'package:moon_walker/widgets/appBar.dart';
import 'package:moon_walker/widgets/listtile_customwidgets.dart';
import 'package:moon_walker/core/contatants/const.dart';
import 'package:moon_walker/presentatation/favaouriteScreen/fav_icon.dart';
import 'package:moon_walker/presentatation/now_mini/mini_laast.dart';
import 'package:moon_walker/presentatation/playlist/add.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../infrastructure/functions/convertaudio.dart';


class favouriteScreen extends StatefulWidget {
  favouriteScreen({super.key});

  @override
  State<favouriteScreen> createState() => _favouriteScreenState();
}

class _favouriteScreenState extends State<favouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar(context, 'Favourites'),
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
        child: Padding(
          padding: const EdgeInsets.only(
          left:9.0,right: 9),
          child: ValueListenableBuilder(
            valueListenable: favarotList,
            builder: (context, value, child) =>
            (favarotList.value.isEmpty) ? noSong() : favouritebuilderfunction(),
          ),
        ),
      ),
    );
  }


  Center noSong() {
    return const Center(
      child: Text(
        'Favourite is empty',
        style: TextStyle(fontFamily: 'Peddana', fontSize: 14),
      ),
    );
  }

  favouritebuilderfunction() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 20,),
          child: InkWell(
            onTap: () {
              audioConvert(favarotList.value, index);
              showBottomSheet(
                context: context,
                builder: ((context) => miniLast()),
              );
            },
            child: listTileWidget(
              index: index,
              context: context,
              title: Text(
                favarotList.value[index].songname!,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                favarotList.value[index].artist ?? 'unknown',
              ),
              leading: QueryArtworkWidget(
                artworkFit: BoxFit.cover,
                id: favarotList.value[index].id!,
                type: ArtworkType.AUDIO,
                nullArtworkWidget: ClipRRect(
                  borderRadius: BorderRadius.circular(27),
                  child: Image.asset(
                    MusicImages.instance.queryImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              trailing1: favIcon(
                currentSong: favarotList.value[index],
                isfav: true,
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
                            addToPlaylistSong: favarotList.value[index],
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
                  const PopupMenuItem(
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
          ),
        );
      },
      itemCount: favarotList.value.length,
    );
  }
}
