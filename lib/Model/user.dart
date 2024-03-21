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
  int day15 = 0;
  int day30 = 0;
  int day45 = 0;
  int day60 = 0;
  int day75 = 0;
  int day90 = 0;

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
        "day15": day15,
        "day30": day30,
        "day45": day45,
        "day60": day60,
        "day75": day75,
        "day90": day90,
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
