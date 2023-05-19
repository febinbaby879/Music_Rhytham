import 'package:flutter/material.dart';
import 'package:moon_walker/screens/play_music.dart';
import 'package:on_audio_query/on_audio_query.dart';

class LiistView extends StatefulWidget {
  const LiistView({super.key});

  @override
  State<LiistView> createState() => _LiistViewState();
}

class _LiistViewState extends State<LiistView> {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SongModel>>(
      future: _audioQuery.querySongs(
        sortType: null,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true),
      builder: (context, item) {
        if (item.data == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (item.data!.isEmpty) {
          return Center(
            child: Text('No songs found'),
          );
        }
        return ListView.separated(
          itemBuilder: (ctx, i) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
              ),
              child: ListTile(onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>bigMusic()));
              },
                leading: Container(
                  width: 50,
                  height: 50,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/clown-listening-to-music-relaxing-35822021.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  item.data![i].displayNameWOExt,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(item.data![i].artist.toString()),
                trailing: popupAllSongs(),
              ),
            );
          },
          separatorBuilder: (ctx, i) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * .01,
            );
          },
          itemCount: item.data!.length,
        );
      },
    );
  }
}

class listview extends StatelessWidget {
  const listview({
    required this.item,
    super.key,
  });
  final item;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 7,
        );
      },
      itemCount: item.data!.length,
      itemBuilder: (context, i) {
        return Card(
          color: Colors.white10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => bigMusic(),
                ),
              );
              // buildContainer(i, item);
            },
            title: Text(
              item.data![i].title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(item.data![i].artist ?? "No Artist"),
            // This Widget will query/load image.
            // You can use/create your own widget/method using [queryArtwork].
            leading: Container(
              width: 50,
              height: 50,
              child: CircleAvatar(
                backgroundImage: AssetImage(
                'assets/images/clown-listening-to-music-relaxing-35822021.jpg'),
              ),
            ),
            trailing: popupAllSongs(),
          ),
        );
      },
    );
  }
}

class popupAllSongs extends StatelessWidget {
  const popupAllSongs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          // onTap: () {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (Context) => favouriteScreen(),
          //     ),
          //   );
          // },
          child: Row(
            children: [
              Icon(Icons.favorite_outline),
              SizedBox(
                width: 20,
              ),
              Text('Add to favourite'),
            ],
          ),
        ),
        PopupMenuItem(
          // onTap: () {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => playList(),
          //     ),
          //   );
          // },
          child: Row(
            children: [
              Icon(Icons.list),
              SizedBox(width: 20),
              Text('Add to playlist'),
            ],
          ),
        ),
      ],
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}