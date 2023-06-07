import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moon_walker/screens/commen_widgets/newPLay_list.dart';
import 'package:moon_walker/screens/const.dart';
import 'package:moon_walker/screens/playlist/add.dart';
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
                //playlistBodyNotifier.notifyListeners(),
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
      child: Text('Oops Playlist is empty'),
    );
  }

  ValueListenableBuilder<dynamic> playListView() {
    return ValueListenableBuilder(
      valueListenable: playlistBodyNotifier,
      builder: (context, value, child) => (ListView.separated(
          itemBuilder: (context, i) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) =>
                          playListUnique(playList: playListNotifier.value[i])),
                );
              },
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
                  height: 85,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0, top: 15),
                    child: ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                              image: AssetImage('assets/images/img2.jpg'),
                              fit: BoxFit.cover),
                        ),
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
                            deleteConfrimDilog(context, i);
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
                            ),
                          ),
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
                ),
              ),
            );
          },
          separatorBuilder: (context, i) {
            return SizedBox(
              height: 6,
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


  deleteConfrimDilog(BuildContext context, int i) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            //title: Text('Are you sure'),
            content: Text('ARE YOU SURE'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('No')),
              ElevatedButton(
                  onPressed: () {
                    playlistdelete(i);
                    Navigator.of(context).pop();
                  },
                  child: Text('Yes')),
            ],
          );
        });
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
            key: playListCreateFormKey,
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
                if (playListCreateFormKey.currentState!.validate()) {
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
}
