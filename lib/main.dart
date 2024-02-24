import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moodmate/screens/DemoPage.dart';
import 'package:moodmate/screens/home_screen.dart';
import 'package:moodmate/screens/signin_screen.dart';
import 'package:moodmate/screens/signup_screen.dart';
import 'package:moodmate/screens/welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key});
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // NOTE: here i am adding GetMaterialApp() because i try to use GetX and Obx class
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: WelcomePage()
        home: splashPage()
        // NOTE: this for testing
        // home: HomeScreen()

        // TODO: this for uploading the music to firebase directly from the application.
        // home: DemoPage()
        );
  }
}

// README: modified this because i want the initState function for shared preferences use
class splashPage extends StatefulWidget {
  const splashPage({Key? key}) : super(key: key);

  @override
  State<splashPage> createState() => splashPageState();
}

class splashPageState extends State<splashPage> {
  static const String KEYLOGIN = "login";

  @override
  void initState() {
    super.initState();

    whereToGo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WelcomePage(),
    );
  }

  void whereToGo() async {
    var sharedPref = await SharedPreferences.getInstance();

    var isLoggedIn = sharedPref.getBool(KEYLOGIN);

      if(isLoggedIn!=null){
        if(isLoggedIn){
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => SignInScreen()));
        }
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignInScreen()));
      }
  }
}
