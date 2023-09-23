import 'package:flutter/material.dart';

class FriendScreen extends StatefulWidget {
  const FriendScreen({super.key});

  @override
  State<FriendScreen> createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  @override
  Widget build(BuildContext context) {
        return Scaffold(
      body: Center(
          child: Text(
        "Friends",
        style: TextStyle(fontSize: 40),
      )),
    );
  }
}