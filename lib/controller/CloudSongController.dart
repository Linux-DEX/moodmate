import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:moodmate/Model/MySongModel.dart';

class CloudSongController extends GetxController {
  final db = FirebaseFirestore.instance;

  RxList<MySongModel> cloudSongList = RxList<MySongModel>([]);

  @override
  void onInit() {
    getCloudSound();
    super.onInit();
  }

  void uploadSongToDB() async {
    MySongModel newSong = MySongModel(
      id: 1,
      title: "Memories",
      artist: "Benjamin Tissot",
      album: "album",
      data:
          "https://firebasestorage.googleapis.com/v0/b/moodmate-cc86c.appspot.com/o/musics%2Fmemories.mp3?alt=media&token=f3bcf465-4cad-4cb8-b51e-3609cc1c9a66",
    );

    await db.collection("songs").add(newSong.toJson());
    print(" song upload to database 👌👌");
  }

  void getCloudSound() async {
    cloudSongList.clear();
    await db.collection("songs").get().then((value) {
      value.docs.forEach((element) {
        cloudSongList.add(MySongModel.fromJson(element.data()));
      });
    });
  }
}
