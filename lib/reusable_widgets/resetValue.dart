// NOTE: The firebase value reset function

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

setUserTasks() async {
  String userId = FirebaseAuth.instance.currentUser!.uid;

  List<dynamic> tasks = [false, false, false, false, false];

  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'todaytask': tasks});

    print("updated successfully");
  } catch (e) {
    print(e.toString());
  }
}

void checkDayfirebase() {
  setUserTasks();
  print("checkDay function running...");
}
