import 'package:flutter/material.dart';
import 'package:moodmate/screens/first_page.dart';
import 'package:moodmate/screens/friend_screen.dart';
import 'package:moodmate/screens/music_screen.dart';
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
    MusicScreen(),
    FriendScreen(),
    SettigScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        // ! navigation bar
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(indicatorColor: Colors.transparent),
          child: NavigationBar(
            height: 60,
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
              NavigationDestination(
                  icon: Icon(Icons.music_note_outlined),
                  selectedIcon: Icon(Icons.music_note),
                  label: "music"),
              NavigationDestination(
                  icon: Icon(Icons.group_outlined),
                  selectedIcon: Icon(Icons.group),
                  label: "friend"),
              NavigationDestination(
                  icon: Icon(Icons.settings_outlined),
                  selectedIcon: Icon(Icons.settings),
                  label: "settings"),
            ],
          ),
        ),
        body: screen[index],
      ),
    );
  }
}
