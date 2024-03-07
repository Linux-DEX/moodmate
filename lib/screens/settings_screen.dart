import 'package:flutter/material.dart';
import 'package:moodmate/main.dart';
import 'package:moodmate/screens/welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettigScreen extends StatefulWidget {
  const SettigScreen({super.key});

  @override
  State<SettigScreen> createState() => _SettigScreenState();
}

class _SettigScreenState extends State<SettigScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.4,),
          Center(
              child: Text(
            "settings",
            style: TextStyle(fontSize: 40),
          )),
          ElevatedButton(
            child: Text('logout', style: TextStyle(color: Colors.white),),
            style: ElevatedButton.styleFrom(
                // padding: EdgeInsets.fromLTRB(
                //     MediaQuery.of(context).size.width * 0.2,
                //     20,
                //     MediaQuery.of(context).size.width * 0.2,
                //     20),
                //primary: Color.fromARGB(255, 110, 120, 241),
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                )),
            onPressed: () async {
              var sharedPref = await SharedPreferences.getInstance();
              sharedPref.setBool(splashPageState.KEYLOGIN, false);

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => WelcomePage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
