import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moodmate/components/SongTile.dart';
import 'package:moodmate/controller/CloudSongController.dart';
import 'package:moodmate/controller/SongPlayerController.dart';
import 'package:moodmate/controller/songDataController.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  @override
  Widget build(BuildContext context) {
    SongDataController songDataController = Get.put(SongDataController());
    SongPlayerController songPlayerController = Get.put(SongPlayerController());
    CloudSongController cloudSongController = Get.put(CloudSongController());
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(children: [
            SizedBox(height: 20),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        songDataController.isDeviceSong.value = false;
                      },
                      child: Text("Cloud Song",
                          style: TextStyle(
                            fontSize: 20,
                            color: songDataController.isDeviceSong.value
                                ? Colors.black38
                                : Colors.orange,
                          ))),
                  InkWell(
                    onTap: () {
                      songDataController.isDeviceSong.value = true;
                    },
                    child: Text(
                      "Device Song",
                      style: TextStyle(
                        fontSize: 20,
                        color: songDataController.isDeviceSong.value
                            ? Colors.orange
                            : Colors.black38,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Obx(
              () => songDataController.isDeviceSong.value
                  ? Column(
                      children: songDataController.localSongList.value
                          .map((e) => SongTile(
                                onPress: () {
                                  songPlayerController.playLocalAudio(e);
                                  songDataController
                                      .findCurrentSongPlayingIndex(e.id);
                                  Navigator.pop(context);
                                  // songPlayerController.songTitle.value = e.title;
                                },
                                songName: e.title,
                              ))
                          .toList())
                  : Column(
                    // BUG: It is not able to next and previous the cloud music 
                    // TODO: fix the bug here 
                      children: cloudSongController.cloudSongList.value
                          .map((e) => SongTile(
                                onPress: () {
                                  songPlayerController.playCloudAudio(e);
                                  songDataController
                                      .findCurrentSongPlayingIndex(e.id!);
                                  Navigator.pop(context);
                                },
                                songName: e.title!,
                              ))
                          .toList(),
                    ),
            )
          ]),
        ),
      )),
    );
  }
}
