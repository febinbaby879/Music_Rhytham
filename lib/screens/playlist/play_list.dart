import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moon_walker/screens/playlist/add_toplaList.dart';
import 'package:moon_walker/screens/playlist/new_playlist.dart';
import 'package:moon_walker/widgets/rename_playlist.dart';

import '../../database/play_lists/db_functions/play_listfunc.dart';

class playList extends StatefulWidget {
  const playList({super.key});

  @override
  State<playList> createState() => _playListState();
}

class _playListState extends State<playList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          createNewplaylistForAddToPlaylist(context);
                        },
                        child: Text('Create new playlist'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: playListNotifier,
                    builder: (context, value, child) {
                      return ListView.separated(
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Container(
                                width: 50,
                                height: 50,
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/images/musizz.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: Text(value[index].name),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 21,
                            );
                          },
                          itemCount: value.length);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: Text(
        'PLAY LISTS',
        style: GoogleFonts.kavoon(fontSize: 21),
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

  createNewplaylistForAddToPlaylist(BuildContext context) {
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
                    labelText: 'Enter Playlist Name',
                    prefixIcon: const Icon(
                      Icons.mode_edit_outline_rounded,
                      size: 30,
                    ),
                    border: OutlineInputBorder(
                        //borderSide:  BorderSide(color: redColor),
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {});
                      playlistControllor.text = '';
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                        ),
                        textStyle: const TextStyle(
                          fontSize: 15,
                        )),
                    child: const Text('Cancel'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (playlistFormkey.currentState!.validate()) {
                      playlistCreating(playlistControllor.text);
                      setState(() {});
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
      },
    );
  }
}

class playlistPopupp extends StatelessWidget {
  const playlistPopupp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        if (value == 'page1') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => renamePlayList(context)),
          );
        } else {
          //Delete function.
        }
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<String>(
          value: 'page1',
          child: Text('Rename'),
        ),
        PopupMenuItem<String>(
          value: 'page12',
          child: Text('Delete'),
        ),
      ],
    );
  }
}
