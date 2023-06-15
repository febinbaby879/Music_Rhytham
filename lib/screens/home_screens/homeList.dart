import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moon_walker/database/Allsongs/model/allSongModel.dart';
import 'package:moon_walker/database/Allsongs/songDbfi_func/song_db_func.dart';
import 'package:moon_walker/database/Favourite/functions/fav_func.dart';
import 'package:moon_walker/screens/commen_widgets/listtile_customwidgets.dart';
import 'package:moon_walker/screens/contatants/const.dart';
import 'package:moon_walker/screens/favaouriteScreen/fav_icon.dart';
import 'package:moon_walker/screens/favaouriteScreen/favouriteScreen.dart';
import 'package:moon_walker/screens/fetchPermission/convert_audio.dart';
import 'package:moon_walker/screens/fetchPermission/fetch_songs.dart';
import 'package:moon_walker/screens/mostplayed/mostplayed.dart';
import 'package:moon_walker/screens/now_mini/mini_laast.dart';
import 'package:moon_walker/screens/playlist/add.dart';
import 'package:moon_walker/screens/playlist/play_list.dart';
import 'package:moon_walker/screens/recentsongs/recentJUstcheck.dart';
import 'package:moon_walker/screens/search/search.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shimmer/shimmer.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(musicImages.instance.scaffBackImg),
            fit: BoxFit.cover,
            opacity: 190),
        gradient: LinearGradient(
          colors: ScafBack,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 9, top: 12, left: 9),
          child: Container(
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 200.0,
                        child: Shimmer.fromColors(
                          baseColor: Colors.deepPurple.shade800.withOpacity(.9),
                          highlightColor: Colors.amber,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Lets' feel it",
                              style: GoogleFonts.aBeeZee(
                                fontSize: 30.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => searchScreen(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.search,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Container(
                  height: 150,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => favouriteScreen(),
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image:
                                      AssetImage(musicImages.instance.favBoxImg),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              width: 150,
                            ),
                            Positioned(
                              top: 130,
                              child: Opacity(
                                opacity: .7,
                                child: Container(
                                  child: Center(
                                      child: Text(
                                    'Favourites',
                                    style: GoogleFonts.abel(),
                                  )),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(12),
                                        bottomRight: Radius.circular(12),
                                      )),
                                  width: 150,
                                  height: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => playList()));
                        },
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                      image:
                                          AssetImage(musicImages.instance.playImg),
                                      fit: BoxFit.cover)),
                              width: 150,
                            ),
                            Positioned(
                              top: 130,
                              child: Opacity(
                                opacity: .7,
                                child: Container(
                                  child: Center(
                                      child: Text('Playlists',
                                          style: GoogleFonts.abel())),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(12),
                                        bottomRight: Radius.circular(12),
                                      )),
                                  width: 150,
                                  height: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>mostplayed()));
                        },
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          musicImages.instance.mostBoxImg),
                                      fit: BoxFit.cover)),
                              width: 150,
                            ),
                            Positioned(
                              top: 130,
                              child: Opacity(
                                opacity: 0.7,
                                child: Container(
                                  child: Center(
                                      child: Text('Mostly Played',
                                          style: GoogleFonts.abel())),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(12),
                                        bottomRight: Radius.circular(12),
                                      )),
                                  width: 150,
                                  height: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "All Songs",
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: ValueListenableBuilder(
                      valueListenable: allsongBodyNotifier,
                      builder: (context, value, child) =>
                          allsongBodyNotifier.value.isNotEmpty
                              ? songNotFound()
                              : allSongsListview(
                                  allSongs,
                                ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListView allSongsListview(List<Songs> song) {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: ((context, index) {
          return InkWell(
            onTap: () async {
              AudioConvert(allSongs, index);
              // recentSongsList.add(index);
              showBottomSheet(
                context: context,
                builder: ((context) => miniLast()),
              );
            },
            child: listTileWidget(
              index: index,
              context: context,
              leading: QueryArtworkWidget(
                  nullArtworkWidget: Container(
                    width: 50,
                    height: 50,
                    child: ClipOval(
                      child: Image.asset(
                        musicImages.instance.queryImage,
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
              subtitle: Text(allSongs[index].artist ?? 'No artist',overflow: TextOverflow.ellipsis,),
              trailing1: favIcon(
                currentSong: allSongs[index],
                isfav: favarotList.value.contains(
                  allSongs[index],
                ),
              ),
              trailing2: PopupMenuButton(
                iconSize: 30,
                onSelected: (value) {
                  if (value == 0) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddToPlaylist(
                          addToPlaylistSong: allSongs[index],
                        ),
                      ),
                    );
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                shadowColor: Colors.brown,
                itemBuilder: (context) => [
                  PopupMenuItem(
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
          );
        }),
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 0,
          );
        },
        itemCount: allSongs.length);
  }

  Center songNotFound() {
    return Center(
      child: Text("No songs available"),
    );
  }
}
