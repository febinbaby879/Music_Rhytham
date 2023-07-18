import 'package:flutter/material.dart';
import 'package:moon_walker/widgets/newPLay_list.dart';
import 'package:moon_walker/widgets/snackbar.dart';
import 'package:moon_walker/core/contatants/const.dart';
import 'package:moon_walker/presentatation/playlist/play_list.dart';

import '../../domain/Allsongs/model/allSongModel.dart';
import '../../infrastructure/dbfunc/playlist/play_listfunc.dart';

class AddToPlaylist extends StatelessWidget {
  final Songs addToPlaylistSong;
  AddToPlaylist({super.key, required this.addToPlaylistSong});

  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ADD TO PLAYLIST',
          style: TextStyle(fontFamily: 'Roboto'),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              createNewplaylist(context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(MusicImages.instance.scaffBackImg),
              fit: BoxFit.cover,
              opacity: 230),
          gradient: LinearGradient(
              colors: scafBack,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextField(
                    onChanged: (value) => search(value),
                    controller: _playlistSearchControllor,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.search),
                      hintText: 'Find Playlist',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            (playListNotifier.value.isEmpty)
                ? const Expanded(
                    child: Center(
                      child: Text(
                        'Create New Playlist',
                      ),
                    ),
                  )
                : Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: playListNotifier,
                      builder: (context, value, child) =>
                          _playlistSearchControllor.text.isEmpty ||
                                  _playlistSearchControllor.text.trim().isEmpty
                              ? selecPlayListAdding(
                                  context, addToPlaylistSong)
                              : playListNotifier.value.isEmpty
                                  ? connotFindPlayList()
                                  : searchFindAfterAdding(
                                      context, addToPlaylistSong),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget connotFindPlayList() {
    return const SizedBox(
      child: Center(
        child: Text(
          'Sorry baeab 🤷',
        ),
      ),
    );
  }

  search(String searchtext) {
    playListNotifier.value = playListNotifier.value
        .where(
          (element) => element.name.toLowerCase().contains(
                searchtext.toLowerCase().trim(),
              ),
        )
        .toList();
  }

  Widget selecPlayListAdding(BuildContext context, Songs addToPlaylistSong) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            if (playListNotifier.value[index].Container
                .contains(addToPlaylistSong)) {
              SnackBaaaar(
                text: 'Song is already exist',
                context: context,
              );
            } else {
              playListNotifier.value[index].Container
                  .add(addToPlaylistSong);
              playlistAddDB(
                  addToPlaylistSong, playListNotifier.value[index].name);
              SnackBaaaar(
                text: 'Song added',
                context: context,
              );
              Navigator.of(context).pop();
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: PlaylistSearchTile(
              title: playListNotifier.value[index].name,
              context: context,
              index: index,
            ),
          ),
        );
      },
      itemCount: playListNotifier.value.length,
    );
  }

  Widget searchFindAfterAdding(BuildContext context, Songs addToPlaylistSong) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            if (playListNotifier.value[index].Container
                .contains(addToPlaylistSong)) {
              SnackBaaaar(
                text: 'Song is already existing',
                context: context,
              );
            } else {
              playListNotifier.value[index].Container
                  .add(addToPlaylistSong);
              playlistAddDB(addToPlaylistSong,
                  playListNotifier.value[index].name);
              SnackBaaaar(
                text:
                    'Song added to ${playListNotifier.value[index].name}',
                context: context,
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: PlaylistSearchTile(
              title: playListNotifier.value[index].name,
              context: context,
              index: index,
            ),
          ),
        );
      },
      itemCount: playListNotifier.value.length,
    );
  }
}

//Form State control key
final playListCreateFormKey = GlobalKey<FormState>();

//Serach playlist
TextEditingController _playlistSearchControllor = TextEditingController();

class PlaylistSearchTile extends StatelessWidget {
  final int index;
  final BuildContext context;
  final title;

  PlaylistSearchTile({
    super.key,
    required this.index,
    required this.context,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: miniplayerColor,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          height: 70,
          child: Padding(
            padding: const EdgeInsets.only(top: 7),
            child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(MusicImages.instance.playListImg),fit: BoxFit.cover
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              title: Text(title),
            ),
          ),
        ),
      ),
    );
  }
}
