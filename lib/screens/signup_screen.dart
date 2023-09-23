import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moodmate/reusable_widgets/reusable_widget.dart';
import 'package:moodmate/screens/home_screen.dart';
import 'package:moodmate/screens/signin_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  bool? isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24,color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(children: <Widget>[
              SizedBox(
                height: 35,
              ),
              Image.asset(
                "assets/images/signoutlogo.png",
                width: MediaQuery.of(context).size.width,
              ),
              SizedBox(
                height: 5,
              ),
              reusableTextField("Full Name ", Icons.person_outline, false,
                  _userNameTextController),
              SizedBox(
                height: 20,
              ),
              reusableTextField("Enter Email id", Icons.person_outline, false,
                  _emailTextController),
              SizedBox(
                height: 20,
              ),
              reusableTextField("Password", Icons.lock_outlined, true,
                  _passwordTextController),
              SizedBox(
                height: 5,
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                      value: isChecked,
                      onChanged: (newValue) {
                        setState(() {
                          isChecked = newValue;
                        });
                      }),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "I agree to terms and conditions",
                    style: TextStyle(fontSize: 17.0),
                  )
                ],
              ),
              signInSignUpButton(context, false, () {
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: _emailTextController.text,
                            password: _passwordTextController.text)
                        .then((value) {
                      Navigator.push(
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
        const Text("Already have an account?",
            style: TextStyle(color: Color.fromARGB(179, 79, 79, 80))),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignInScreen()));
          },
          child: const Text(
            "  Login",
            style: TextStyle(
                color: Color.fromARGB(255, 84, 187, 228),
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
