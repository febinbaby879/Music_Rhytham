import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moon_walker/database/Allsongs/model/allSongModel.dart';
import 'package:moon_walker/screens/commen_widgets/listtile_customwidgets.dart';
import 'package:moon_walker/screens/favaouriteScreen/fav_icon.dart';
import 'package:moon_walker/screens/favaouriteScreen/favouriteScreen.dart';
import 'package:moon_walker/screens/fetchPermission/convert_audio.dart';
import 'package:moon_walker/screens/fetchPermission/fetch_songs.dart';
import 'package:moon_walker/screens/now_mini/mini_laast.dart';
import 'package:moon_walker/screens/playlist/add.dart';
import 'package:on_audio_query/on_audio_query.dart';

ValueNotifier<List<Songs>> data = ValueNotifier([]);

class searchScreen extends StatefulWidget {
  const searchScreen({super.key});

  @override
  State<searchScreen> createState() => _searchScreenState();
}

final TextEditingController _searchControllor = TextEditingController();

class _searchScreenState extends State<searchScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
              left: 15, right: 15, top: 23, bottom: 20),
              child: TextFormField(
                onChanged: (value) => search(value),
                controller: _searchControllor,
                autofocus: true,
                decoration: InputDecoration(
                    icon: Icon(Icons.search),
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
              valueListenable: data,
              builder: (context, value, child) => Expanded(
                child: _searchControllor.text.isEmpty ||
                        _searchControllor.text.trim().isEmpty
                    ? searchFunc(context)
                    : data.value.isEmpty
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
      data.notifyListeners();
    } else {
      Navigator.of(context).pop();
    }
  }

 searchfound(BuildContext ctx2) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            AudioConvert(data.value, index);

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
                data.value[index].songname!,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                '${data.value[index].artist}',
              ),
              leading: QueryArtworkWidget(
                id: data.value[index].id!,
                type: ArtworkType.AUDIO,
                nullArtworkWidget: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.asset(
                    'assets/images/musizz.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              trailing1: favIcon(
                currentSong: data.value[index],
                isfav: favarotList.value.contains(data.value[index]),
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
                                  addToPlaylistSong: data.value[index]),
                                ),
                              );
                            },
                            child: const Text(
                              'ADD TO PLAYLIST',
                            ),
                          ),
                        ),
                      ]),
            ),
          ),
        ),
      ),
      itemCount: data.value.length,
    );
  }

 searchFunc(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            AudioConvert(allSongs, index);
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
                        'assets/images/musizz.jpg',
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(Icons.playlist_add),
                          const Text(
                            'ADD TO PLAYLIST',
                          ),
                        ],
                      ),
                    ),
                  )
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
    data.value = allSongs
        .where((element) => element.songname!
            .toLowerCase()
            .contains(searchtext.toLowerCase().trim()))
        .toList();
  }
}
