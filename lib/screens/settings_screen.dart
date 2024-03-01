import 'package:flutter/material.dart';
import 'package:moodmate/main.dart';
import 'package:moodmate/reusable_widgets/day_report.dart';
import 'package:moodmate/reusable_widgets/weekly_report.dart';
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  SizedBox(width: MediaQuery.of(context).size.width * 0.2),
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 2, 10, 10),
              child: Text(
                "Daily Report",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            DailyReport(context),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 2, 10, 10),
              child: Text(
                "Weekly Report",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            WeeklyReport(context),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            // ! Logo Out button
            // ElevatedButton(
            //   child: Text(
            //     'logout',
            //     style: TextStyle(color: Colors.white),
            //   ),
            //   style: ElevatedButton.styleFrom(
            //       // padding: EdgeInsets.fromLTRB(
            //       //     MediaQuery.of(context).size.width * 0.2,
            //       //     20,
            //       //     MediaQuery.of(context).size.width * 0.2,
            //       //     20),
            //       primary: Color.fromARGB(255, 110, 120, 241),
            //       textStyle: const TextStyle(
            //         color: Colors.white,
            //         fontSize: 20,
            //       )),
            //   onPressed: () async {
            //     var sharedPref = await SharedPreferences.getInstance();
            //     sharedPref.setBool(splashPageState.KEYLOGIN, false);
        
            //     Navigator.pushReplacement(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => WelcomePage(),
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
