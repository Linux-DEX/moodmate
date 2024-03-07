import 'package:flutter/material.dart';
import 'package:moodmate/screens/signup_screen.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/welcomepage.png"),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "It's Ok Not To Be OKAY!!",
                  style: TextStyle(color: Colors.white, fontSize: 40),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text('Let Us Help You', style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.2,
                          20,
                          MediaQuery.of(context).size.width * 0.2,
                          20),
                      //primary: Color.fromARGB(255, 44, 3, 115),
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      )),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpScreen(),
                      ),
                    );
                  },
                ),
              ]),
        ),
      ),
    );
  }
}
