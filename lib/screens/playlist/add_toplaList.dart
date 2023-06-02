import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moon_walker/screens/playlist/play_list_class.dart';

import '../../database/play_lists/db_functions/play_listfunc.dart';

class AddToPlaylist extends StatefulWidget {
  AddToPlaylist({super.key});

  @override
  State<AddToPlaylist> createState() => _AddToPlaylistState();
}

// ----playlistBodyNotifier for rebuilding the playlist body
ValueNotifier playlistBodyNotifier = ValueNotifier([]);
// ----playlistNotifier for  creating playlist objects and its contain the playlist name and container
ValueNotifier<List<EachPlayList>> playListNotifier = ValueNotifier([]);
//Form State control key
final playlistFormkey = GlobalKey<FormState>();
//Text access
TextEditingController playlistControllor = TextEditingController();

class _AddToPlaylistState extends State<AddToPlaylist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADD TO PLAYLIST'),
        centerTitle: true,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Center(
            child: FaIcon(
              FontAwesomeIcons.angleLeft,
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              createNewplaylistForAddToPlaylist(context);
            },
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(
                  'NEW PLAYLIST',
                ),
              ),
            ),
          ),
          SizedBox(
            height: 21,
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: playListNotifier,
              builder: (context, list, child) {
                return ListView.separated(
                    itemBuilder: (ctx, index) {
                      return Card(
                        color: Colors.purple,
                        child: ListTile(
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
                          title: Text(list[index].name),
                          //trailing: PopupMenuButton(
                            // onSelected: (value) {
                            //   if (value == 0) {
                            //     Navigator.of(context).push(
                            //       MaterialPageRoute(
                            //         builder: (context) => AddToPlaylist(),
                            //       ),
                            //     );
                            //   }
                            // shape: RoundedRectangleBorder(
                            //   borderRadius: BorderRadius.circular(12),
                            // ),
                            // shadowColor: Colors.brown,
                            // itemBuilder: (context) => [
                            //   PopupMenuItem(
                            //     child: Row(
                            //       mainAxisAlignment:
                            //       MainAxisAlignment.spaceBetween,
                            //       children: [
                            //         Icon(Icons.delete),
                            //         Text('Delete'),
                            //       ],
                            //     ),
                            //   ),
                            //   PopupMenuItem(
                            //     child: Row(
                            //       mainAxisAlignment:
                            //       MainAxisAlignment.spaceBetween,
                            //       children: [
                            //         Icon(Icons.create),
                            //         Text('Renam'),
                            //       ],
                            //     ),
                            //   ),
                            // ],
                          //),
                        ),
                      );
                    },
                    separatorBuilder: (ctx, index) {
                      return SizedBox(
                        height: 20,
                      );
                    },
                    itemCount: list.length);
              },
            ),
          ),
        ],
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
