import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moon_walker/database/play_lists/db_functions/play_listfunc.dart';
import 'package:moon_walker/screens/commen_widgets/listtile_customwidgets.dart';
import 'package:moon_walker/screens/commen_widgets/snackbar.dart';
import 'package:moon_walker/screens/favaouriteScreen/fav_icon.dart';
import 'package:moon_walker/screens/favaouriteScreen/favouriteScreen.dart';
import 'package:moon_walker/screens/fetchPermission/convert_audio.dart';
import 'package:moon_walker/screens/now_mini/mini_laast.dart';
import 'package:moon_walker/screens/playlist/play_list_class.dart';
import 'package:on_audio_query/on_audio_query.dart';

class playListUnique extends StatefulWidget {
  final EachPlayList playList;
  playListUnique({super.key, required this.playList});

  @override
  State<playListUnique> createState() => _playListUniqueState();
}

ValueNotifier plusiconNotifier = ValueNotifier([]);

class _playListUniqueState extends State<playListUnique> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldkey,
      body: SafeArea(
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
                      icon: Icon(Icons.arrow_back),
                    ),
                    Text(
                      'Play list ' + widget.playList.name.toUpperCase(),
                      style: GoogleFonts.kavoon(fontSize: 18),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: plusiconNotifier,
                  builder: (context, value, child) {
                    return ListView.separated(
                        itemBuilder: ((context, index) {
                          return InkWell(
                              onTap: () {
                                AudioConvert(widget.playList.Container, index);
                                showBottomSheet(
                                  context: context,
                                  builder: (context) => miniLast(),
                                );
                              },
                              child: playListTileCalling(context, index));
                        }),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 15),
                        itemCount: widget.playList.Container.length);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
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
            'assets/images/musizz.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        widget.playList.Container[i].songname!,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(widget.playList.Container[i].artist??'unknown'),
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
                backgroundColor: Colors.blueGrey);
            playListSongDelete(
                widget.playList.Container[i], widget.playList.name);
            setState(() {
              widget.playList.Container.removeAt(i);
            });
          }
        },
        itemBuilder: (context) => [
          PopupMenuItem(
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
