import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moon_walker/database/Allsongs/model/allSongModel.dart';
import 'package:moon_walker/screens/commen_widgets/listtile_customwidgets.dart';
import 'package:moon_walker/screens/favaouriteScreen/fav_icon.dart';
import 'package:moon_walker/screens/favaouriteScreen/favouriteScreen.dart';
import 'package:moon_walker/screens/fetchPermission/convert_audio.dart';
import 'package:moon_walker/screens/fetchPermission/fetch_songs.dart';
import 'package:moon_walker/screens/now_mini/mini_laast.dart';
import 'package:moon_walker/screens/playlist/add_toplaList.dart';
import 'package:moon_walker/screens/playlist/play_list.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shimmer/shimmer.dart';

ValueNotifier allsongBodyNotifier = ValueNotifier([]);

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    List<Audio> songAudioList = allSongsAudioList;
    return SafeArea(
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
                      height: 60.0,
                      child: Shimmer.fromColors(
                        baseColor: Color.fromARGB(255, 206, 141, 136),
                        highlightColor: Color.fromARGB(255, 99, 93, 38),
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
                      onPressed: () {},
                      icon: Icon(
                        Icons.grid_view_rounded,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => searchscreen(),
                        //   ),
                        // );
                      },
                      icon: Icon(
                        Icons.search,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  children: [
                    Container(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) => favouriteScreen()),
                          );
                        },
                      ),
                      height: 150,
                      width: MediaQuery.of(context).size.width * .4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/best websites for free music1640190686306255.jpg'),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Spacer(),
                    Container(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => playList(),
                            ),
                          );
                        },
                      ),
                      height: 150,
                      width: MediaQuery.of(context).size.width * .4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/166142112-mans-hands-playing-acoustic-guitar-close-up-acoustic-guitars-playing-music-concept-guitars.jpg'),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text('Favourites'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 130.0),
                      child: Text(
                        'Playlist',
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
                child: ValueListenableBuilder(
                  valueListenable: allsongBodyNotifier,
                  builder: ((context, value, child) => allSongs.isEmpty
                      ? songNotFound()
                      : allSongsListview(
                          songAudioList,
                          allSongs.cast<SongsAll>(),
                        )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView allSongsListview(List<Audio> songAudio, List<SongsAll> song) {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: ((context, index) {
          return InkWell(
            onTap: ()async{
              playingAudio(allSongs,index);
              showBottomSheet(
                context: context,
                builder: ((context) => miniLast()),
              );
            },
            child: ListtileCustomWidget(
              index: index,
              context: context,
              leading: QueryArtworkWidget(
                  nullArtworkWidget: Container(
                    width: 50,
                    height: 50,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/musizz.jpg',
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
              trailing1: favIcon(
                currentSong: allSongs[index],
                isfav: favarotList.value.contains(
                  allSongs[index],
                ),
              ),
              trailing2: PopupMenuButton(
                onSelected: (value) {
                  //if (value == 0) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => playList(),
                      ),
                    );
                  },
                //},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                shadowColor: Colors.brown,
                itemBuilder: (context) => [
                  PopupMenuItem(
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
