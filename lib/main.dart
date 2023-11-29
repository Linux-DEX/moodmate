import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moodmate/screens/home_screen.dart';
import 'package:moodmate/screens/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        // * change this after completing project
        home: HomeScreen()
        );
  }
}
