// NOTE: This page is only for uploading the music to firebase and testing no need to do any changes in it.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moodmate/controller/CloudSongController.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    CloudSongController cloudSongController = Get.put(CloudSongController());
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('CALLL DATABASE'),
          onPressed: () {
            // README: this for reading data from firebase
             cloudSongController.getCloudSound();
            // README: this for uploading song to firebase
            // cloudSongController.uploadSongToDB();
          },
        ),
      ),
    );
  }
}
