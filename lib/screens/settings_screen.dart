import 'package:flutter/material.dart';

class SettigScreen extends StatefulWidget {
  const SettigScreen({super.key});

  @override
  State<SettigScreen> createState() => _SettigScreenState();
}

class _SettigScreenState extends State<SettigScreen> {
  @override
  Widget build(BuildContext context) {
        return Scaffold(
      body: Center(
          child: Text(
        "settings",
        style: TextStyle(fontSize: 40),
      )),
    );
  }
}