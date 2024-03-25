// NOTE: The firebase value reset function

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

setUserTasks() async {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  Map<String, String> dayMood = {
    "sunday": "",
    "monday": "",
    "tuesday": "",
    "wednesday": "",
    "thursday": "",
    "friday": "",
    "saturday": "",
  };
  Map<String, int> moodValue = {
    "depress": 0,
    "stress": 0,
    "anger": 0,
    "sad": 0,
    "relax": 0,
    "happy": 0,
  };
  List<dynamic> tasks = [false, false, false, false, false];

  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'todaytask': tasks});
    print("updated successfully");

    DateTime now = DateTime.now();
    String today = DateFormat('EEEE').format(now).toLowerCase();
    if (today == 'monday') {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'dayMood': dayMood, 'moodValue': moodValue});
    }
  } catch (e) {
    print(e.toString());
  }
}

void checkDayfirebase() {
  setUserTasks();
  print("checkDay function running...");
}
