import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moon_walker/database/Allsongs/model/allSongModel.dart';
import 'package:moon_walker/screens/commen_widgets/listtile_customwidgets.dart';
import 'package:moon_walker/screens/favaouriteScreen/fav_icon.dart';
import 'package:moon_walker/screens/fetchPermission/convert_audio.dart';
import 'package:moon_walker/screens/now_mini/mini_laast.dart';
import 'package:moon_walker/screens/playlist/add.dart';
import 'package:on_audio_query/on_audio_query.dart';

ValueNotifier<List<Songs>> favarotList = ValueNotifier([]);

class favouriteScreen extends StatefulWidget {
  favouriteScreen({super.key});

  @override
  State<favouriteScreen> createState() => _favouriteScreenState();
}

class _favouriteScreenState extends State<favouriteScreen> {
  @override
  Widget build(BuildContext context) {
    //getFAvourite();
    return Scaffold(
      appBar: appBarfav(context),
      body: Padding(
        padding: const EdgeInsets.only(left:9.0,right: 9),
        child: ValueListenableBuilder(
          valueListenable: favarotList,          
          builder: (context, value, child) =>
          (favarotList.value.isEmpty) ? noSong() : favouritebuilderfunction(),
        ),
      ),
    );
  }

  appBarfav(BuildContext context) {
    return AppBar(
      title: Text(
        'FAVOURITES',
        style: GoogleFonts.kavoon(),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: InkWell(
        onTap: () => Navigator.of(context).pop(),
        child: const Center(
          child: FaIcon(
            FontAwesomeIcons.angleLeft,
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
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 20,),
          child: InkWell(
            onTap: () async {
              AudioConvert(favarotList.value, index);
              //convertToAudioList(favarotList.value);
              showBottomSheet(
                context: context,
                builder: ((context) => miniLast()),
              );
              //playingAudio(favarotList.value, index);
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
                    'assets/images/musizz.jpg',
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
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 0,
        );
      },
      itemCount: favarotList.value.length,
    );
  }
}
