import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moodmate/main.dart';
import 'package:moodmate/reusable_widgets/reusable_widget.dart';
import 'package:moodmate/screens/forgot_password.dart';
import 'package:moodmate/screens/home_screen.dart';
import 'package:moodmate/screens/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Login",
          style: TextStyle(
              fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    "assets/images/signinlogo.png",
                    width: MediaQuery.of(context).size.width,
                    height:MediaQuery.of(context).size.height*0.45 ,
                  ),
                  // signinLogoWidget("assets/images/signinlogo.png"),
                  SizedBox(
                    height: 5,
                  ),
                  RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                          text: "Welcome",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                                text: " Back!",
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold))
                          ])),
                  Text("Continue your calmness journey."),
                  SizedBox(
                    height: 10,
                  ),
                  reusableTextField("Enter UserId", Icons.person_outline, false,
                      _emailTextController),
                  SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Password", Icons.lock_outlined, true,
                      _passwordTextController),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPasswordScreen()));
                        },
                        child: const Text(
                          " Forgot Password",
                          style: TextStyle(
                              color: Color.fromARGB(255, 84, 187, 228),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  signInSignUpButton(context, true, () async {
                    // FIXME: do testing for this code here and async above
                    var sharedPref = await SharedPreferences.getInstance();
                    sharedPref.setBool(splashPageState.KEYLOGIN, true);

                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: _emailTextController.text,
                            password: _passwordTextController.text)
                        .then((value) {
                      print("Log In");
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    }).onError((error, stackTrace) {
                      print("Error ${error.toString()}");
                    });
                  }),
                  signUpOption()
                ]),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Color.fromARGB(179, 79, 79, 80))),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            "  Sign Up",
            style: TextStyle(
                color: Color.fromARGB(255, 84, 187, 228),
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
