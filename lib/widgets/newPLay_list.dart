import 'package:flutter/material.dart';
import 'package:moon_walker/presentatation/playlist/add.dart';
import 'package:moon_walker/presentatation/playlist/play_list.dart';

import '../infrastructure/dbfunc/playlist/play_listfunc.dart';

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
            key: playListCreateFormKey,
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
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
                      backgroundColor: Colors.purple,
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
                  if (playListCreateFormKey.currentState!.validate()) {
                    playlistCreating(playlistControllor.text);
                    playlistControllor.text = '';
                    Navigator.of(ctx).pop();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 21,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 15,
                  ),
                ),
                child: const Text('Confirm'),
              ),
            ],
          ),
        ],
      );
    },
  );
}
