import 'dart:async';
import 'package:flutter/material.dart';
import 'package:moon_walker/database/Allsongs/model/allSongModel.dart';
import 'package:moon_walker/database/play_lists/db_functions/play_listfunc.dart';
import 'package:moon_walker/screens/commen_widgets/newPLay_list.dart';
import 'package:moon_walker/screens/commen_widgets/snackbar.dart';
import 'package:moon_walker/screens/const.dart';
import 'package:moon_walker/screens/playlist/play_list.dart';
import 'package:moon_walker/screens/playlist/play_list_class.dart';

class AddToPlaylist extends StatefulWidget {
  final Songs addToPlaylistSong;
  const AddToPlaylist({super.key, required this.addToPlaylistSong});

  @override
  State<AddToPlaylist> createState() => _AddToPlaylistState();
}

//Form State control key
final playListCreateFormKey = GlobalKey<FormState>();
//Text access
TextEditingController playlistControllor = TextEditingController();
ValueNotifier<List<EachPlayList>> playlistSearchNotifier = ValueNotifier([]);
TextEditingController _playlistSearchControllor = TextEditingController();

class _AddToPlaylistState extends State<AddToPlaylist> {
  double screenWidth = 0;

  bool startAnimation = false;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ADD TO PLAYLIST',
          style: TextStyle(fontFamily: 'Roboto'),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              createNewplaylist(context);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 90,
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      onChanged: (value) => search(value),
                      controller: _playlistSearchControllor,
                      decoration: InputDecoration(
                        icon: Icon(Icons.search),
                        hintText: 'Find Playlist',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
                    valueListenable: playlistSearchNotifier,
                    builder: (context, value, child) =>
                        _playlistSearchControllor.text.isEmpty ||
                                _playlistSearchControllor.text.trim().isEmpty
                            ? searchFunctionplaylist(
                                context, widget.addToPlaylistSong)
                            : playlistSearchNotifier.value.isEmpty
                                ? searchEmptyPlaylist()
                                : searchFoundcplaylist(
                                    context, widget.addToPlaylistSong),
                  ),
                ),
        ],
      ),
    );
  }

  Widget searchEmptyPlaylist() {
    return const SizedBox(
      child: Center(
        child: Text(
          'Sorry baeab 🤷',
        ),
      ),
    );
  }

  search(String searchtext) {
    playlistSearchNotifier.value = playListNotifier.value
        .where((element) => element.name
            .toLowerCase()
            .contains(searchtext.toLowerCase().trim()))
        .toList();
  }


  Widget searchFunctionplaylist(BuildContext context, Songs addToPlaylistSong) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            if (playListNotifier.value[index].Container
                .contains(widget.addToPlaylistSong)) {
              SnackBaaaar(
                  text: 'Song is already exist',
                  context: context,
                  backgroundColor: Colors.blueGrey);
            } else {
              playListNotifier.value[index].Container
                  .add(widget.addToPlaylistSong);
              playlistAddDB(
                  widget.addToPlaylistSong, playListNotifier.value[index].name);
              SnackBaaaar(
                  text: 'Song added',
                  context: context,
                  backgroundColor: Colors.blueGrey);
            }

            Timer(const Duration(milliseconds: 900), () {
              playlistBodyNotifier.notifyListeners();
              Navigator.of(context).pop();
            });
          },
          child: PlaylistSearchTile(
            title: playListNotifier.value[index].name,
            context: context,
            index: index,
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox();
      },
      itemCount: playListNotifier.value.length,
    );
  }

  Widget searchFoundcplaylist(BuildContext context, Songs addToPlaylistSong) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            if (playlistSearchNotifier.value[index].Container
                .contains(widget.addToPlaylistSong)) {
              SnackBaaaar(
                  text: 'Song is already existing',
                  context: context,
                  backgroundColor: Colors.blueGrey);
            } else {
              playlistSearchNotifier.value[index].Container
                  .add(widget.addToPlaylistSong);
              playlistAddDB(widget.addToPlaylistSong,
                  playlistSearchNotifier.value[index].name);
              SnackBaaaar(
                  text:
                      'Song added to ${playlistSearchNotifier.value[index].name}',
                  context: context,
                  backgroundColor: Colors.blueGrey);
            }
          },
          child: PlaylistSearchTile(
            title: playlistSearchNotifier.value[index].name,
            context: context,
            index: index,
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox();
      },
      itemCount: playlistSearchNotifier.value.length,
    );
  }
}

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
          width: MediaQuery.of(context).size.width * 0.5,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: miniplayerColor,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          height: 85,
          child: Row(
            children: [
              const Spacer(
                flex: 1,
              ),
              Container(
                height: 70,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/img2.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              Text(
                title,
              ),
              const Spacer(
                flex: 6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
