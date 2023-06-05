import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moon_walker/screens/playlist/add_toplaList.dart';
import 'package:moon_walker/screens/playlist/playListUnique.dart';
import 'package:moon_walker/screens/playlist/play_list_class.dart';
import '../../database/play_lists/db_functions/play_listfunc.dart';

class playList extends StatefulWidget {
  const playList({super.key});

  @override
  State<playList> createState() => _playListState();
}

// ----playlistBodyNotifier for rebuilding the playlist body
ValueNotifier playlistBodyNotifier = ValueNotifier([]);
// ----playlistNotifier for  creating playlist objects and its contain the playlist name and container
ValueNotifier<List<EachPlayList>> playListNotifier = ValueNotifier([]);

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
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: playlistBodyNotifier,
                    builder: (context, value, child) =>
                        (playListNotifier.value.isEmpty)
                            ? emptyPlaylist()
                            : playListView(),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          createNewplaylist(context);
                        },
                        child: Text('New playlist'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Center emptyPlaylist() {
    return Center(
      child: Text('Playlist is empty'),
    );
  }

  ValueListenableBuilder<dynamic> playListView() {
    return ValueListenableBuilder(
      valueListenable: playlistBodyNotifier,
      builder: (context, value, child) => (ListView.separated(
          itemBuilder: (context, i) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        playListUnique(playList: playListNotifier.value[i])));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  hoverColor: Colors.amber,
                  leading: Container(
                    width: 50,
                    height: 50,
                    child: Image.asset('assets/images/images.jpeg'),
                  ),
                  title: Text(playListNotifier.value[i].name),
                  trailing: PopupMenuButton(
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onSelected: (value) {
                      if (value == 0) {
                        rename(
                          context,
                          i,
                        );
                      } else {
                        delete(context);
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                          value: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.edit),
                              Text('Edit'),
                            ],
                          )),
                      PopupMenuItem(
                        value: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.delete),
                            Text('Delete'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, i) {
            return SizedBox(
              height: 14,
            );
          },
          itemCount: playListNotifier.value.length)),
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

  createNewplaylist(BuildContext context) {
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
                      //setState(() {});
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
                      //setState(() {});
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

  rename(BuildContext context, int i) {
    TextEditingController rename = TextEditingController();
    rename.text = playListNotifier.value[i].name;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Rename playlist"),
          content: Form(
            key: playlistFormkey,
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Enter playlist name'),
              controller: rename,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name is required';
                } else {
                  for (var element in playListNotifier.value) {
                    if (element.name == rename.text) {
                      return 'Name is already exist';
                    }
                  }
                }
                return null;
              },
            ),
          ),
          actions: [
            ElevatedButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text("OK"),
              onPressed: () {
                if (playlistFormkey.currentState!.validate()) {
                  setState(() {
                    playlistrename(i, rename.text);
                  });
                  playlistControllor.text = '';
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  delete(BuildContext context) {}
}
