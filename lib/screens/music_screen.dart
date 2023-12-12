import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:moodmate/controller/CloudSongController.dart';
import 'package:moodmate/controller/SongPlayerController.dart';
import 'package:moodmate/controller/songDataController.dart';
import 'package:moodmate/screens/SongPage.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen({super.key});

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  SongPlayerController songPlayerController = Get.put(SongPlayerController());
  SongDataController songDataController = Get.put(SongDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black, size: 32),
        backgroundColor: Colors.white,
        // README: No use of adding the features 
        // leading: Builder(
        //   builder: (BuildContext context) {
        //     return IconButton(
        //         onPressed: () {
        //           print("click");
        //         },
        //         icon: Icon(Icons.keyboard_arrow_down));
        //   },
        // ),
        actions: [
          IconButton(
              onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SongPage(),
                      ),
                    )
                  },
              icon: Icon(Icons.playlist_play_rounded)),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: 30,
            ),
            child: Obx(() =>
                Text(
                songPlayerController.isCloudSongPlaying.value == true ?"Cloud Playlist" : "Device Playlist",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Obx(() =>
              Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                    image: AssetImage(songPlayerController.isCloudSongPlaying.value == true ? 'assets/images/cloudmusic.jpeg' : 'assets/images/images.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          // NOTE: This song title and singer name
          Column(
            children: [
              Obx(
                () => Container(
                  child: Text(
                    "${songPlayerController.songTitle.value}",
                    // songPlayerController.songTitle.value.toString(),
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Obx(
                () => Center(
                  child: Text(
                    "${songPlayerController.songArtist.value}",
                    // songPlayerController.artistName.value.toString(),
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Obx(
            () => Slider(
              value: songPlayerController.sliderValue.value
                  .clamp(0.0, songPlayerController.sliderValue.value),
              onChanged: (value) {
                songPlayerController.sliderValue.value = value;

                Duration songPosition = Duration(seconds: value.toInt());
                songPlayerController.changeSongSlider(songPosition);
              },
              min: 0,
              max: songPlayerController.sliderMaxValue.value,
            ),
          ),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${songPlayerController.currentTime}",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  // Expanded(
                  //     child: Obx(
                  //   () => Slider(
                  //     value: songPlayerController.sliderValue.value,
                  //     onChanged: (value) {
                  //       songPlayerController.sliderValue.value = value;
                  //     },
                  //     min: 0,
                  //     max: songPlayerController.sliderMaxValue.value,
                  //   ),
                  // )),
                  Text("/"),
                  Text("${songPlayerController.totalTime}",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold))
                ],
              )),
          Container(
            alignment: FractionalOffset.center,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(60),
                  splashColor: Colors.black26,
                  onTap: () {
                    songDataController.playPreviousSong();
                  },
                  child: Container(
                    child: CircleAvatar(
                      backgroundColor: Colors.white70,
                      radius: 25,
                      child: ImageIcon(
                        AssetImage('assets/icons/previous.png'),
                        color: Colors.pink[300],
                        size: 40,
                      ),
                    ),
                  ),
                ),

                Obx(
                  () => songPlayerController.isPlaying.value
                      ? InkWell(
                          onTap: () {
                            songPlayerController.pausePlaying();
                          },
                          child: Container(
                            width: 80,
                            height: 80,
                            padding: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: ImageIcon(
                                AssetImage('assets/icons/pause.png'),
                                color: Colors.pink[300],
                                size: 120,
                              ),
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            songPlayerController.resumePlaying();
                          },
                          child: Container(
                            width: 80,
                            height: 80,
                            padding: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: ImageIcon(
                                AssetImage('assets/icons/play-button.png'),
                                color: Colors.pink[300],
                                size: 120,
                              ),
                            ),
                          ),
                        ),
                ),

                InkWell(
                  borderRadius: BorderRadius.circular(60),
                  splashColor: Colors.black26,
                  onTap: () {
                    songDataController.playNextSong();
                  },
                  child: Container(
                    child: CircleAvatar(
                      backgroundColor: Colors.white70,
                      radius: 25,
                      child: ImageIcon(
                        AssetImage('assets/icons/skip.png'),
                        color: Colors.pink[300],
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
