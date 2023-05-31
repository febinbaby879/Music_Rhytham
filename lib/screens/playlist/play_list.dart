import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moon_walker/screens/new_playlist.dart';
import 'package:moon_walker/screens/play_listsongs.dart';
import 'package:moon_walker/widgets/rename_playlist.dart';

class playList extends StatelessWidget {
  const playList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: appBar(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            child: Column(
              children: [
                //appBar(context),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>playListSongs(),),);
                  },
                    leading: Icon(Icons.list_alt_outlined),
                    title: Text('PLaylist one'),
                    trailing: playlistPopupp(),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>playListSongs(),),);
                  },
                    leading: Icon(Icons.list_alt_outlined),
                    title: Text('PLaylist two'),
                    trailing: playlistPopupp(),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>playListSongs(),),);
                  },
                    leading: Icon(Icons.list_alt_outlined),
                    title: Text('PLaylist three'),
                    trailing: playlistPopupp(),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => newPlaylist(),
                            ),
                          );
                        },
                        child: Text('Create new playlist'),
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

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'PLAY LISTS',
        style: TextStyle(
        fontFamily: 'Peddana', fontWeight: FontWeight.w600, fontSize: 16),
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
        }else{
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
