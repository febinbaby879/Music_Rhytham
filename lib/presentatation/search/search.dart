import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moon_walker/infrastructure/dbfunc/favourite/fav_func.dart';
import 'package:moon_walker/widgets/listtile_customwidgets.dart';
import 'package:moon_walker/core/contatants/const.dart';
import 'package:moon_walker/presentatation/favaouriteScreen/fav_icon.dart';
import 'package:moon_walker/presentatation/now_mini/mini_laast.dart';
import 'package:moon_walker/presentatation/playlist/add.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../domain/Allsongs/model/allSongModel.dart';
import '../../infrastructure/functions/convertaudio.dart';
import '../../infrastructure/functions/fetchsongs.dart';



ValueNotifier<List<Songs>> searchdata = ValueNotifier([]);

class searchScreen extends StatefulWidget {
  const searchScreen({super.key});

  @override
  State<searchScreen> createState() => _searchScreenState();
}

final TextEditingController _searchControllor = TextEditingController();

class _searchScreenState extends State<searchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                onChanged: (value) => search(value),
                controller: _searchControllor,
                autofocus: true,
                decoration: InputDecoration(
                    icon:const Icon(Icons.search),
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
                    )),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: searchdata,
              builder: (context, value, child) => Expanded(
                child: _searchControllor.text.isEmpty ||
                        _searchControllor.text.trim().isEmpty
                    ? searchFunc(context)
                    : searchdata.value.isEmpty
                        ? searchEmpty()
                        : searchfound(context),
              ),
            )
          ],
        ),
      ),
    );
  }

  clearText(context) {
    if (_searchControllor.text.isNotEmpty) {
      _searchControllor.clear();
      searchdata.notifyListeners();
    } else {
      Navigator.of(context).pop();
    }
  }

  searchfound(BuildContext ctx2) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:scafBack,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(MusicImages.instance.scaffBackImg),
          fit: BoxFit.cover,
          opacity: 230,
        ),
      ),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(.0),
          child: InkWell(
            onTap: () {
              audioConvert(searchdata.value, index);
              showBottomSheet(
                  context: context,
                  builder: (context) {
                    return miniLast();
                  });
            },
            child: Card(
              child: listTileWidget(
                index: index,
                context: context,
                title: Text(
                  searchdata.value[index].songname!,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  '${searchdata.value[index].artist}',
                ),
                leading: QueryArtworkWidget(
                  id: searchdata.value[index].id!,
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
                  currentSong: searchdata.value[index],
                  isfav: favarotList.value.contains(searchdata.value[index]),
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
                                  addToPlaylistSong: searchdata.value[index]),
                            ),
                          );
                        },
                        child: const Text(
                          'ADD TO PLAYLIST',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        itemCount: searchdata.value.length,
      ),
    );
  }

  searchFunc(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            audioConvert(allSongs, index);
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
                allSongs[index].songname ??= 'unknown',
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                overflow: TextOverflow.ellipsis,
                allSongs[index].artist ??= 'unknown',
              ),
              leading: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                width: MediaQuery.of(context).size.width * 0.14,
                child: ClipRRect(
                  child: QueryArtworkWidget(
                    artworkBorder: BorderRadius.circular(25),
                    id: allSongs[index].id!,
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
              trailing1: favIcon(
                currentSong: allSongs[index],
                isfav: favarotList.value.contains(allSongs[index]),
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
                      child:const Row(
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
      itemCount: allSongs.length,
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

  search(String searchtext) {
    searchdata.value = allSongs
        .where((element) => element.songname!
            .toLowerCase()
            .contains(searchtext.toLowerCase().trim()))
        .toList();
  }
}
