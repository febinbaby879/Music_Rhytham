import 'dart:async';
import 'package:flutter/material.dart';
import 'package:moon_walker/database/Allsongs/model/allSongModel.dart';
import 'package:moon_walker/database/play_lists/db_functions/play_listfunc.dart';
import 'package:moon_walker/screens/commen_widgets/snackbar.dart';
import 'package:moon_walker/screens/playlist/play_list.dart';
import 'package:moon_walker/screens/playlist/play_list_class.dart';

class AddToPlaylist extends StatefulWidget {
  final Songs addToPlaylistSong;
  const AddToPlaylist({super.key, required this.addToPlaylistSong});

  @override
  State<AddToPlaylist> createState() => _AddToPlaylistState();
}

//Form State control key
final playlistFormkey = GlobalKey<FormState>();
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
              createNewplaylistForAddToPlaylist(context);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 80,
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      onChanged: (value) => searchPlaylist(value),
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
                // ----------------Search-------------
              ],
            ),
          ),
          (playListNotifier.value.isEmpty)
              ? const Expanded(
                  child: Center(
                    child: Text(
                      'Create New Playlist',
                      style: TextStyle(
                          color: Color.fromARGB(227, 255, 255, 255),
                          fontFamily: 'Peddana',
                          fontSize: 20),
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

  Future<dynamic> createNewplaylistForAddToPlaylist(BuildContext context) {
    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            content: const Text(
              'Create New Playlist',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            actions: [
              Form(
                key: playlistFormkey,
                child: TextFormField(
                  maxLength: 15,
                  controller: playlistControllor,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'name is requiered';
                    } else {
                      for (var element in playListNotifier.value) {
                        if (element.name == playlistControllor.text) {
                          return 'name is alredy exist';
                        }
                      }
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter Playlist Name',
                    prefixIcon: const Icon(
                      Icons.mode_edit_outline_rounded,
                      size: 25,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        playlistControllor.text = '';
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (playlistFormkey.currentState!.validate()) {
                        playlistCreating(playlistControllor.text);
                        playlistControllor.text = '';
                        Navigator.of(ctx).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 21,
                        ),
                        textStyle: const TextStyle(
                          fontSize: 15,
                        )),
                    child: const Text('Confirm'),
                  ),
                ],
              ),
            ],
          );
        });
  }

  Widget searchEmptyPlaylist() {
    return const SizedBox(
      child: Center(
        child: Text(
          'Playlist Not Found',
        ),
      ),
    );
  }

  searchPlaylist(String searchtext) {
    playlistSearchNotifier.value = playListNotifier.value
        .where(
            (element) => element.name.contains(searchtext.toLowerCase().trim()))
        .toList();
  }

  Widget searchFunctionplaylist(
      BuildContext context, Songs addToPlaylistSong) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            if (playListNotifier.value[index].Container
                .contains(widget.addToPlaylistSong)) {
              // snackbarRemoving(
              //     text: 'song is alredy exist', context: context);
            } else {
              playListNotifier.value[index].Container
                  .add(widget.addToPlaylistSong);
              playlistAddDB(
                  widget.addToPlaylistSong, playListNotifier.value[index].name);

              // snackbarAdding(
              //     text: 'song added to ${playListNotifier.value[index].name}',
              //     context: context);
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

  Widget searchFoundcplaylist(
      BuildContext context, Songs addToPlaylistSong) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            if (playlistSearchNotifier.value[index].Container
                .contains(widget.addToPlaylistSong)) {
              snackbarAdding(
                  text: 'Song is already existing',
                  context: context,
                  backgroundColor: Colors.blueGrey);
            } else {
              playlistSearchNotifier.value[index].Container
                  .add(widget.addToPlaylistSong);
              playlistAddDB(widget.addToPlaylistSong,
                  playlistSearchNotifier.value[index].name);
              snackbarAdding(
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

// --------------------Its Just A List tile -------------------
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
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 15,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
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

