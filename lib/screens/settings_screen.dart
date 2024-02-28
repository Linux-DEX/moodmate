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
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(48),
                      // child: Image.asset("assets/images/Calm.png"),
                      child: const CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://res.cloudinary.com/demo/image/facebook/65646572251.jpg"),
                        ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width*0.2),
                  Text(
                    "USER-NAME",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.05),
            Container(
              height: 250,
              width: MediaQuery.of(context).size.width*0.8,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                  image: AssetImage("assets/images/graph.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.05),
            // Center(
            //     child: Text(
            //   "settings",
            //   style: TextStyle(fontSize: 40),
            // )),
            ElevatedButton(
              child: Text('logout', style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                  // padding: EdgeInsets.fromLTRB(
                  //     MediaQuery.of(context).size.width * 0.2,
                  //     20,
                  //     MediaQuery.of(context).size.width * 0.2,
                  //     20),
                  primary: Color.fromARGB(255, 110, 120, 241),
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
      ),
    );
  }
}
