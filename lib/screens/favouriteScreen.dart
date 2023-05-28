import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moon_walker/screens/colors.dart';
import 'package:moon_walker/screens/commen_widgets/listtile_customwidgets.dart';
import 'package:on_audio_query/on_audio_query.dart';

ValueNotifier<List<SongModel>> favarotList = ValueNotifier([]);

class favouriteScreen extends StatefulWidget {
  favouriteScreen({super.key});

  @override
  State<favouriteScreen> createState() => _favouriteScreenState();
}

class _favouriteScreenState extends State<favouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarfav(context),
      body: ValueListenableBuilder(valueListenable: favarotList, builder: (context, value, child) => (favarotList.value.isEmpty)
              ? const Center(
                  child: Text(
                    'Favourite is empty',
                    style: TextStyle(
                     fontFamily: 'Peddana', fontSize: 26),
                  ),
                )
              : favouritebuilderfunction(),),
    );
  }

  appBarfav(BuildContext context) {
    return AppBar(
      title: const Text(
        'FAVOURITES',
        style: TextStyle(
        fontFamily: 'Peddana', fontWeight: FontWeight.w600, fontSize: 16),
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
  favouritebuilderfunction() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
          child: AnimatedContainer(
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: 600 + (index * 20)),
            child: InkWell(
              onTap: () {
                //playingAudio(favoritelist.value, index);

                // showBottomSheet(
                //     backgroundColor: transparentColor,
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(20)),
                //     context: context,
                //     builder: (context) {
                //       return const MiniPlayer();
                //     });
              },
              child: ListtileCustomWidget(
                index: index,
                context: context,
                title: Text(
                  favarotList.value[index].displayName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                  fontWeight: FontWeight.bold, color: whiteColor),
                ),
                subtitle: Text(
                  favarotList.value[index].artist ?? 'unknown',
                  style: const TextStyle(color: whiteColor),
                ),
                leading: QueryArtworkWidget(
                  size: 3000,
                  quality: 100,
                  artworkQuality: FilterQuality.high,
                  artworkBorder: BorderRadius.circular(10),
                  artworkFit: BoxFit.cover,
                  id: favarotList.value[index].id,
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/photo-1544785349-c4a5301826fd.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // trailing1: Hearticon(
                //   refresh: true,
                //   currentSong: favoritelist.value[index],
                //   isfav: true,
                // ),
                // trailing2: PopupMenuButton(
                //     onSelected: (value) {
                //       if (value == 0) {
                //         Navigator.of(context).push(MaterialPageRoute(
                //             builder: (ctx) => AddToPlaylist(
                //                   addToPlaylistSong: favarotList.value[index],
                //                 )));
                //       }
                //     },
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(15)),
                //     color: backgroundColorDark,
                //     icon: const FaIcon(
                //       FontAwesomeIcons.ellipsisVertical,
                //       color: whiteColor,
                //       size: 26,
                //     ),
                //     itemBuilder: (context) => [
                //           PopupMenuItem(
                //             value: 0,
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: const [
                //                 Text(
                //                   'ADD TO PLAYLIST',
                //                   style: TextStyle(
                //                       color: whiteColor,
                //                       fontWeight: FontWeight.w400,
                //                       fontFamily: 'Peddana',
                //                       fontSize: 18),
                //                 ),
                //                 Icon(
                //                   Icons.playlist_add,
                //                   color: whiteColor,
                //                 )
                //               ],
                //             ),
                //           )
                //         ]),
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
    );}
}
