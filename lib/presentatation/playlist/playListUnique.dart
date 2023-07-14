import 'package:flutter/material.dart';
import 'package:moon_walker/infrastructure/dbfunc/favourite/fav_func.dart';
import 'package:moon_walker/widgets/listtile_customwidgets.dart';
import 'package:moon_walker/widgets/snackbar.dart';
import 'package:moon_walker/core/contatants/const.dart';
import 'package:moon_walker/presentatation/favaouriteScreen/fav_icon.dart';
import 'package:moon_walker/presentatation/now_mini/mini_laast.dart';
import 'package:moon_walker/presentatation/playlist/play_list.dart';
import 'package:moon_walker/presentatation/playlist/play_list_class.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../infrastructure/dbfunc/playlist/play_listfunc.dart';
import '../../infrastructure/functions/convertaudio.dart';
import '../../infrastructure/functions/fetchsongs.dart';

class playListUnique extends StatefulWidget {
  final uniqueList playList;
  final int ind;
  playListUnique({super.key, required this.playList,required this.ind});

  @override
  State<playListUnique> createState() => _playListUniqueState();
}

class _playListUniqueState extends State<playListUnique> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon:const Icon(Icons.arrow_back),
                      ),
                      Text(
                        'Play list ' + widget.playList.name.toUpperCase(),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          addSongFromUnique(context);
                        },
                        icon:const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: playListNotifier,
                    builder: (context, value, child) {
                      return ListView.separated(
                      itemBuilder: ((context, index) {
                        return InkWell(
                          onTap: () {
                            audioConvert(widget.playList.Container, index);
                            showBottomSheet(
                              context: context,
                              builder: (context) => miniLast(),
                            );
                          },
                          child: (widget.playList.Container.isEmpty)?noSongsplyList():playListTileCalling(context, index),
                          //playListTileCalling(context, index),
                        );
                      }),
                      separatorBuilder: (context, index) => SizedBox(),
                      itemCount: widget.playList.Container.length,
                    );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Center noSongsplyList(){
    return const Center(child: Text('Oops no more songs'),);
  }
  addSongFromUnique(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return listTileWidget(
              index: index,
              context: context,
              leading: QueryArtworkWidget(
                  nullArtworkWidget: Container(
                    width: 50,
                    height: 50,
                    child: ClipOval(
                      child: Image.asset(
                        MusicImages.instance.queryImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  id: allSongs[index].id!,
                  type: ArtworkType.AUDIO),
              title: Text(
                allSongs[index].songname!,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(allSongs[index].artist ?? 'No artist'),
              trailing2: IconButton(
                onPressed: () {
                  if (playListNotifier.value[index].Container
                .contains(allSongs[index])) {
              SnackBaaaar(
                text: 'Song is already exist',
                context: context,
              );
            } else {
              playListNotifier.value[index].Container
                  .add(allSongs[index]);
              playlistAddDB(
                  allSongs[index], playListNotifier.value[index].name);
                  widget.playList.Container.add(allSongs[index]);
              SnackBaaaar(
                text: 'Song added',
                context: context,
              );
              Navigator.of(context).pop();
            }
                },
                icon:const Icon(Icons.add),
              ),
            );
          },
          itemCount: allSongs.length,
        );
      },
    );
  }

  playListTileCalling(BuildContext context, int i) {
    return listTileWidget(
      index: i,
      context: context,
      leading: QueryArtworkWidget(
        id: widget.playList.Container[i].id!,
        type: ArtworkType.AUDIO,
        nullArtworkWidget: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image.asset(
            MusicImages.instance.queryImage,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        widget.playList.Container[i].songname!,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(widget.playList.Container[i].artist ?? 'unknown'),
      trailing1: favIcon(
        currentSong: widget.playList.Container[i],
        isfav: favarotList.value.contains(widget.playList.Container[i]),
      ),
      
      trailing2: PopupMenuButton(
        onSelected: (value) {
          if (value == 0) {
            SnackBaaaar(
              text: 'Remove from playlist ${widget.playList.name}',
              context: context,
            );
            playListSongDelete(
                widget.playList.Container[i], widget.playList.name);
            setState(() {
              widget.playList.Container.removeAt(i);
            });
          }
        },
        itemBuilder: (context) => [
         const PopupMenuItem(
            value: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.delete_forever,
                  color: Colors.redAccent,
                ),
                Text('Remove this song'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
