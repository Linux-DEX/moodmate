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
  Map<String, Map<String, int>> moodValue = {
    "sunday": {
      "depress": 0,
      "stress": 0,
      "anger": 0,
      "sad": 0,
      "relax": 0,
      "happy": 0,
    },
    "monday": {
      "depress": 0,
      "stress": 0,
      "anger": 0,
      "sad": 0,
      "relax": 0,
      "happy": 0,
    },
    "tuesday": {
      "depress": 0,
      "stress": 0,
      "anger": 0,
      "sad": 0,
      "relax": 0,
      "happy": 0,
    },
    "wednesday": {
      "depress": 0,
      "stress": 0,
      "anger": 0,
      "sad": 0,
      "relax": 0,
      "happy": 0,
    },
    "thursday": {
      "depress": 0,
      "stress": 0,
      "anger": 0,
      "sad": 0,
      "relax": 0,
      "happy": 0,
    },
    "friday": {
      "depress": 0,
      "stress": 0,
      "anger": 0,
      "sad": 0,
      "relax": 0,
      "happy": 0,
    },
    "saturday": {
      "depress": 0,
      "stress": 0,
      "anger": 0,
      "sad": 0,
      "relax": 0,
      "happy": 0,
    },
  };
  List<dynamic> tasks = [false, false, false, false, false];
  var userData = {};
  double addValue = 0;

  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'todaytask': tasks});
    print("updated TodayTask successfully");

    var userSnap =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    userData = userSnap.data()!;

    DateTime now = DateTime.now();
    String today = DateFormat('EEEE').format(now).toLowerCase();
    if (today == 'monday') {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'prevDayMood': userData['dayMood'],
        'prevMoodValue': userData['moodValue'] ?? moodValue
      });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'dayMood': dayMood, 'moodValue': moodValue});

      {
        // ERROR: This is not getting updated to the firebase 
        // userData.forEach((day, mood) {
        //   addValue += userData['prevMoodValue']![day]![mood];
        // });

        userData['prevMoodValue']!.forEach((day, moodValues) {
          moodValues.forEach((mood, value) {
            addValue += value.toDouble(); 
          });
        });

        userData['day7'] = (addValue / 35) * 100;
        userData['day14'] = ( ((userData['day7']!*35)/100 + addValue) / 70) * 100;
        userData['day21'] = ( ((userData['day14']!*70)/100 + addValue) / 105) * 100;
        userData['day28'] = ( ((userData['day21']!*105)/100 + addValue) / 140) * 100;
        userData['day35'] = ( ((userData['day28']!*140)/100 + addValue) / 175) * 100;
        userData['day42'] = ( ((userData['day35']!*175)/100 + addValue) / 210) * 100;

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({ 
              'day7': userData['day7']!.toInt(),
              'day14': userData['day14']!.toInt(),
              'day21': userData['day21']!.toInt(),
              'day28': userData['day28']!.toInt(),
              'day35': userData['day35']!.toInt(),
              'day42': userData['day42']!.toInt(),
            });
      }
    }
  } catch (e) {
    print(e.toString());
  }
}

void checkDayfirebase() {
  setUserTasks();
  print("checkDay function running...");
}
