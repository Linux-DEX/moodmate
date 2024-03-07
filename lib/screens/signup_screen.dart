import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moodmate/resources/auth_methods.dart';
import 'package:moodmate/reusable_widgets/reusable_widget.dart';
import 'package:moodmate/screens/home_screen.dart';
import 'package:moodmate/screens/signin_screen.dart';
import 'package:moodmate/screens/welcome_page.dart';
import 'package:moodmate/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _userBioTextController = TextEditingController();//New Added
  Uint8List? _image;//new Added
  bool _isLoading=false;//new Added
  bool? isChecked = false;

  void selectImage()async
  {
      Uint8List im= await pickImage(ImageSource.gallery);
      setState(() {
        _image=im;
      });
  }
  void signUpUser()async
  {
    setState(() {
      _isLoading=true;
    });
    String res = await AuthMethods().signUpUser(email:_emailTextController.text ,
                   password: _passwordTextController.text, 
                   username: _userNameTextController.text,
                    bio: _userBioTextController.text,
                    file: _image!);
                    setState(() {
                      _isLoading=false;
                    });
                    if(res != "success")
                    {
                      showSnackBar(res, context);
                    }
                    else
                    {
                     Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()));
                    }
  }
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
                height: 50,
              ),
              Stack(
                children: [_image!=null? CircleAvatar(radius: 64,
                backgroundImage:MemoryImage(_image!) ,)
                :
                CircleAvatar(radius: 64,
                backgroundImage: NetworkImage('https://t4.ftcdn.net/jpg/02/15/84/43/360_F_215844325_ttX9YiIIyeaR7Ne6EaLLjMAmy4GvPC69.jpg'),),
                Positioned(child: IconButton(onPressed: selectImage,icon: const Icon(Icons.add_a_photo),),
                bottom: -10,left: 80,)],
                
              ),
              SizedBox(
                height: 10,
              ),
              reusableTextField("Full Name ", Icons.person_outline, false,
                  _userNameTextController),
              SizedBox(
                height: 20,
              ),
              reusableTextField("Bio ", Icons.person_outline, false,
                  _userBioTextController),
               SizedBox(
                height: 20,
                child: _isLoading?Center(child: CircularProgressIndicator()):Text(''),
              ),
              reusableTextField("Enter Email id", Icons.person_outline, false,
                  _emailTextController),
              SizedBox(
                height: 20,
              ),
              reusableTextField("Password", Icons.lock_outlined, true,
                  _passwordTextController),
              SizedBox(
                height: 20,
              ),
              
              //Working old Code
              /*signInSignUpButton(context, false, () {
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: _emailTextController.text,
                            password: _passwordTextController.text)
                        .then((value) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()));
                    }).onError((error, stackTrace) {
                      print("Error ${error.toString()}");
                    });
                  }),*/
                  signInSignUpButton(context, false, signUpUser,),

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
