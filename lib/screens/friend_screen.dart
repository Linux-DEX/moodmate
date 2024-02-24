import 'package:flutter/material.dart';
import 'package:moodmate/components/FriendsTile.dart';

class FriendScreen extends StatefulWidget {
  const FriendScreen({super.key});

  @override
  State<FriendScreen> createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "FRIENDS",
            style: TextStyle(
              fontWeight: FontWeight.w500
            ),
          ),
        actions: [
          IconButton(
              onPressed: () => {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => SongPage(),
                    //   ),
                    // )
                  },
              icon: Icon(Icons.person_add_alt_1_rounded)),
        ],
      ),
      body: SafeArea(
        child: Center(
            child: Container(
              width: double.maxFinite, 
              height: double.maxFinite, 
              decoration: BoxDecoration( 
                gradient: LinearGradient( 
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Color(0xFFffc2c2), Colors.white], 
                ), 
            ), 
              child: Column(
                children: [
                  FriendsTile(),
                  FriendsTile(),
                ],
              ),
            )),
      ),
    );
  }
}