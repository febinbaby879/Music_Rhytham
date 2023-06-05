import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moon_walker/screens/playlist/play_list.dart';
import 'package:moon_walker/screens/playlist/play_list_class.dart';

import '../../database/play_lists/db_functions/play_listfunc.dart';

class AddToPlaylist extends StatefulWidget {
  final tittle;
  AddToPlaylist({super.key,required this.tittle});

  @override
  State<AddToPlaylist> createState() => _AddToPlaylistState();
}
ValueNotifier<List<EachPlayList>> playlistSearchNotifier = ValueNotifier([]);
TextEditingController _playlistSearchControllor = TextEditingController();

//Form State control key
final playlistFormkey = GlobalKey<FormState>();
//Text access
TextEditingController playlistControllor = TextEditingController();

class _AddToPlaylistState extends State<AddToPlaylist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Find playlist',
                  prefixIcon: Icon(
                    Icons.search_sharp
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: playListNotifier,
                  builder: (context, list, child) {
                    return ListView.separated(
                        itemBuilder: (ctx, index) {
                          return InkWell(
                            onTap: () {
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (context) => playListUnique(playList: playListNotifier.value[index],),
                              //   ),
                              // );
                            },
                            child: Card(
                              child: ListTile(
                                leading: Container(
                                  width: 50,
                                  height: 50,
                                  child: ClipOval(
                                    child: Image.asset(
                                      'assets/images/images.jpeg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                title: Text(list[index].name),
                              ),
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
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        createNewplaylistForAddToPlaylist(context);
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
