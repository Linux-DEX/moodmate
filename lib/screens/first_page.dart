import 'package:flutter/material.dart';
import 'dart:async';
import 'package:moodmate/components/calm_list.dart';
import 'package:moodmate/components/focus_list.dart';
import 'package:moodmate/components/happy_list.dart';
import 'package:moodmate/components/relax_list.dart';
import 'package:moodmate/screens/home_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  bool isVisible = true;
  List img = ['Calm.png', 'Focus.png', 'Happy.png', 'Relax.png'];
  List<String> items = [
    "Calm",
    "Focus",
    "Happy",
    "Relax",
  ];
  List listChange = [CalmList(), FocusList(), HappyList(), RelaxList()];
  
  int current = 0;

  // ? function for visibility
  void _toggleVisibility() {
    setState(() {
      isVisible = !isVisible;
    });

    Timer(Duration(seconds: 5), () {
      setState(() {
        isVisible = !isVisible;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen()));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        actions: [
          // Padding(
          //   padding: EdgeInsets.all(8.0),
          //   child: Container(
          //     width: 35,
          //     height: 35,
          //     child: const CircleAvatar(
          //       backgroundImage: NetworkImage(
          //           "https://res.cloudinary.com/demo/image/facebook/65646572251.jpg"),
          //     ),
          //   ),
          // )
        ],
      ),
      drawer: Drawer(),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                        text: "Welcome back,",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                              text: " UserName",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold))
                        ])),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Text(
                  "How are you feeling today?",
                  style: TextStyle(fontSize: 17),
                ),
              ),
              Visibility(
                visible: isVisible,
                child: Container(
                  width: double.infinity,
                  // height: double.infinity,
                  margin: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 100,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            // itemCount: items.length,
                            itemCount: 4,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  GestureDetector(
                                    // ? static tap
                                    // onTap: () {
                                    //   setState(() {
                                    //     current = index;
                                    //   });
                                    // },
                                    // ? to change the visibility
                                    // onTap: _toggleVisibility,
                                    onTap: () {
                                      current = index;
                                      _toggleVisibility();
                                    },
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      margin: const EdgeInsets.all(5),
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        // color: current == index
                                        //     ? Colors.white70
                                        //     : Colors.white54,
                                        borderRadius: current == index
                                            ? BorderRadius.circular(15)
                                            : BorderRadius.circular(10),
                                            color: Colors.transparent,
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 50,
                                            child: Center(
                                              child: Image.asset(
                                                  'assets/images/${img[index]}'),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(items[index]),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Text(
                  "Today\'s Task",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              // Container(
              //   margin: const EdgeInsets.only(top: 30),
              //   width: double.infinity,
              //   height: 550,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Icon(
              //         icons[current],
              //         size: 200,
              //         color: Colors.deepPurple,
              //       ),
              //       const SizedBox(
              //         height: 10,
              //       ),
              //       Text(
              //         items[current],
              //       ),
              //     ],
              //   ),
              // ),
              Container(
              child: listChange[current],
              )
            ]),
      ),
    );
  }
}
