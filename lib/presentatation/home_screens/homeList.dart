import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moon_walker/application/favourite/favourite_bloc.dart';
import 'package:moon_walker/widgets/listtile_customwidgets.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shimmer/shimmer.dart';
import '../../domain/Allsongs/model/allSongModel.dart';
import '../../infrastructure/dbfunc/allsongs/song_db_func.dart';
import '../../infrastructure/functions/convertaudio.dart';
import '../../infrastructure/functions/fetchsongs.dart';
import '../../core/contatants/const.dart';
import '../favaouriteScreen/fav_icon.dart';
import '../favaouriteScreen/favouriteScreen.dart';
import '../mostplayed/mostplayed.dart';
import '../now_mini/mini_laast.dart';
import '../playlist/add.dart';
import '../playlist/play_list.dart';
import '../search/search.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(MusicImages.instance.scaffBackImg),
            fit: BoxFit.cover,
            opacity: 190),
        gradient: LinearGradient(
          colors: scafBack,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 9, top: 12, left: 9),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 200.0,
                    child: Shimmer.fromColors(
                      baseColor:  Colors.yellow 
                          .withOpacity(.9),
                      highlightColor:const Color.fromARGB(255, 64, 0, 255),
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
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => searchScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.search,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              SizedBox(
                height: 150,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => FavouriteScreen(),
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
                                    AssetImage(MusicImages.instance.favBoxImg),
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
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                    )),
                                width: 150,
                                height: 20,
                                child: Center(
                                    child: Text(
                                  'Favourites',
                                  style: GoogleFonts.abel(),
                                )),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const playList()));
                      },
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                    image: AssetImage(
                                        MusicImages.instance.playImg),
                                    fit: BoxFit.cover)),
                            width: 150,
                          ),
                          Positioned(
                            top: 130,
                            child: Opacity(
                              opacity: .7,
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                    )),
                                width: 150,
                                height: 20,
                                child: Center(
                                    child: Text('Playlists',
                                        style: GoogleFonts.abel())),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const mostplayed()));
                      },
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                    image: AssetImage(
                                        MusicImages.instance.mostBoxImg),
                                    fit: BoxFit.cover)),
                            width: 150,
                          ),
                          Positioned(
                            top: 130,
                            child: Opacity(
                              opacity: 0.7,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                ),
                                width: 150,
                                height: 20,
                                child: Center(
                                    child: Text('Mostly Played',
                                        style: GoogleFonts.abel())),
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
                child: const Text(
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
    );
  }

  ListView allSongsListview(List<Songs> song) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: ((context, index) {
          return InkWell(
            onTap: () async {
              audioConvert(allSongs, index);
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
              subtitle: Text(
                allSongs[index].artist ?? 'No artist',
                overflow: TextOverflow.ellipsis,
              ),
              trailing1: BlocBuilder<FavouriteBloc, FavouriteState>(
                builder: (context, state) {
                  return favIcon(
                    currentSong: allSongs[index],
                    isfav: state.favouriteList.contains(
                      allSongs[index],
                    ),
                  );
                },
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
                itemBuilder: (context) => const [
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
          return const SizedBox(
            height: 0,
          );
        },
        itemCount: allSongs.length);
  }

  Center songNotFound() {
    return const Center(
      child: Text("No songs available please add some songs"),
    );
  }
}
