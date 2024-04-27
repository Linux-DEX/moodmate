import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final List followers;
  final List following;
  final List<bool> todaytask = [false, false, false, false, false];
  Map<String, String> dayMood = {
    "sunday": "",
    "monday": "",
    "tuesday": "",
    "wednesday": "",
    "thursday": "",
    "friday": "",
    "saturday": ""
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
    }
  };
  Map<String, String> prevDayMood = {
    "sunday": "",
    "monday": "",
    "tuesday": "",
    "wednesday": "",
    "thursday": "",
    "friday": "",
    "saturday": ""
  };
  Map<String, Map<String, int>> prevMoodValue = {
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
    }
  };
  double day7 = 0;
  double day14 = 0;
  double day21 = 0;
  double day28 = 0;
  double day35 = 0;
  double day42 = 0;

  User({
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.username,
    required this.bio,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "bio": bio,
        "followers": followers,
        "following": following,
        "todaytask": todaytask,
        "dayMood": dayMood,
        "moodValue": moodValue,
        "prevDayMood": prevDayMood,
        "prevMoodValue": prevMoodValue,
        "day7": day7,
        "day14": day14,
        "day21": day21,
        "day28": day28,
        "day35": day35,
        "day42": day42,
      };
  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      email: snapshot['email'],
      uid: snapshot['uid'],
      photoUrl: snapshot['photoUrl'],
      username: snapshot['username'],
      bio: snapshot['bio'],
      followers: snapshot['followers'],
      following: snapshot['following'],
    );
  }
}
