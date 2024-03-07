import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moodmate/screens/feed_screen.dart';
import 'package:moodmate/screens/first_page.dart';
import 'package:moodmate/screens/friend_screen.dart';
import 'package:moodmate/screens/music_screen.dart';
import 'package:moodmate/screens/post_screen.dart';
import 'package:moodmate/screens/profile_screen.dart';
import 'package:moodmate/screens/search_screen.dart';
import 'package:moodmate/screens/settings_screen.dart';
import 'package:moodmate/screens/signin_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  final screen = [
    FirstScreen(),
    // PostScreen(),
    MusicScreen(),
    FeedScreen(),
    SearchScreen(),
    //SettigScreen(),
    ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,)
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        // ? navigation bar
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(indicatorColor: Colors.transparent),
          child: NavigationBar(
            height: 65,
            backgroundColor: Colors.transparent,
            selectedIndex: index,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            onDestinationSelected: (index) {
              setState(() {
                this.index = index;
              });
            },
            destinations: [
              NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home_rounded),
                  label: "home"),
              // NavigationDestination(
              //     icon: Icon(Icons.add_box_outlined),
              //     selectedIcon: Icon(Icons.add_box),
              //     label: "music"),
              NavigationDestination(
                  icon: Icon(Icons.music_note_outlined),
                  selectedIcon: Icon(Icons.music_note),
                  label: "music"),
              NavigationDestination(
                  icon: Icon(Icons.photo_album_outlined),
                  selectedIcon: Icon(Icons.photo_album_rounded),
                  label: "friend"),
                  NavigationDestination(
                  icon: Icon(Icons.search_outlined),
                  selectedIcon: Icon(Icons.search_rounded),
                  label: "Search"),
                  
              NavigationDestination(
                  icon: Icon(Icons.person_2_outlined),
                  selectedIcon: Icon(Icons.person_2_rounded),
                  label: "Profile"),
            ],
          ),
        ),
        body: screen[index],
      ),
    );
  }
}