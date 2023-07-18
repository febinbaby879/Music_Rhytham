import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moon_walker/application/favourite/favourite_bloc.dart';
import 'package:moon_walker/application/search/search_bloc.dart';
import 'package:moon_walker/widgets/listtile_customwidgets.dart';
import 'package:moon_walker/core/contatants/const.dart';
import 'package:moon_walker/presentatation/favaouriteScreen/fav_icon.dart';
import 'package:moon_walker/presentatation/now_mini/mini_laast.dart';
import 'package:moon_walker/presentatation/playlist/add.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../infrastructure/functions/convertaudio.dart';
import '../../infrastructure/functions/fetchsongs.dart';
import '../favaouriteScreen/favouriteScreen.dart';

class searchScreen extends StatelessWidget {
  searchScreen({super.key});

  final TextEditingController _searchControllor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.read<SearchBloc>().add(Search(query: '', allsongs: allSongs));
    //BlocProvider.of<SearchBloc>(context).add(Search(query: '', allsongs: allSongs));
    return Scaffold(
      //BlocProvider.of<SearchBloc>(context).add(Search(query: '', allsongs: allSongs));
      //context.read<SearchBloc>().add(Search(query: '', allsongs: allSongs));
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              MusicImages.instance.scaffBackImg,
            ),
            fit: BoxFit.cover,
            opacity: 240,
          ),
          gradient: LinearGradient(
            colors: scafBack,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 40,
                bottom: 20,
              ),
              child: TextFormField(
                enableInteractiveSelection: true,
                onChanged: (value) {
                  context
                      .read<SearchBloc>()
                      .add(Search(query: value, allsongs: allSongs));
                },
                controller: _searchControllor,
                autofocus: true,
                decoration: InputDecoration(
                  icon: const Icon(Icons.search),
                  suffixIcon: InkWell(
                    onTap: () {
                      clearText(context);
                    },
                    child: const Icon(
                      Icons.clear_rounded,
                    ),
                  ),
                  filled: true,
                  hintText: 'Search Song',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Expanded(child: searchFunc(context))
            // ValueListenableBuilder(
            //   valueListenable: searchdata,
            //   builder: (context, value, child) => Expanded(
            //     child: _searchControllor.text.isEmpty ||
            //             _searchControllor.text.trim().isEmpty
            //         ? searchFunc(context)
            //         : searchdata.value.isEmpty
            //             ? searchEmpty()
            //             : searchfound(context),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  clearText(context) {
    if (_searchControllor.text.isNotEmpty) {
      _searchControllor.clear();
    } else {
      Navigator.of(context).pop();
    }
  }

  searchFunc(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.searchlist.isEmpty) {
          return searchEmpty();
        }
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                audioConvert(state.searchlist, index);
                showBottomSheet(
                  context: context,
                  builder: (context) {
                    return miniLast();
                  },
                );
              },
              child: Card(
                child: listTileWidget(
                  index: index,
                  context: context,
                  title: Text(
                    state.searchlist[index].songname ?? " unknown Song",
                    overflow: TextOverflow.ellipsis,
                  ),
                  // Text(
                  //   allSongs[index].songname ??= 'unknown',
                  //   overflow: TextOverflow.ellipsis,
                  // ),
                  subtitle: Text(
                    state.searchlist[index].artist ?? " unknown Artist",
                    overflow: TextOverflow.ellipsis,
                  ),
                  // Text(
                  //   overflow: TextOverflow.ellipsis,
                  //   allSongs[index].artist ??= 'unknown',
                  // ),
                  leading: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: MediaQuery.of(context).size.width * 0.14,
                    child: ClipRRect(
                      child: QueryArtworkWidget(
                        artworkBorder: BorderRadius.circular(25),
                        id: state.searchlist[index].id!,
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: ClipOval(
                          child: Image.asset(
                            MusicImages.instance.queryImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  trailing1: BlocBuilder<FavouriteBloc, FavouriteState>(
                    builder: (context, state) {
                      return favIcon(
                        currentSong: allSongs[index],
                        isfav: state.favouriteList.contains(allSongs[index]),
                      );
                    },
                  ),
                  trailing2: PopupMenuButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.ellipsisVertical,
                    ),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 1,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => AddToPlaylist(
                                  addToPlaylistSong: allSongs[index],
                                ),
                              ),
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.playlist_add),
                              Text(
                                'Add to playlist',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          itemCount: state.searchlist.length,
        );
      },
    );
  }

  searchEmpty() {
    return const SizedBox(
      child: Center(
        child: Text(
          'Sorry baeab 🤷',
        ),
      ),
    );
  }
}
