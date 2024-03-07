import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moodmate/Providers/user_provider.dart';
import 'package:moodmate/components/angrey.dart';
import 'dart:async';
import 'package:moodmate/components/depress_list.dart';
import 'package:moodmate/components/happy_list.dart';
import 'package:moodmate/components/my_drawer_header.dart';
import 'package:moodmate/components/relax_list.dart';
import 'package:moodmate/components/sad_list.dart';
import 'package:moodmate/components/stress_list.dart';
import 'package:moodmate/screens/day_bargraph_report.dart';
import 'package:moodmate/screens/day_week_report.dart';
import 'package:moodmate/screens/home_screen.dart';
import 'package:provider/provider.dart';
import "package:moodmate/Model/user.dart" as model;

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  String username = ""; //New
  @override
  void initState() {
    //new
    // TODO: implement initState
    super.initState();
    //getUserName();
    addData();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  void getUserName() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      username = (snap.data() as Map<String, dynamic>)['username'];
    });
  }

  int current = 0;
  bool isVisible = true;

  List img = [
    'depress.png',
    'stress.png',
    'anger.png',
    'sad.png',
    "relax.png",
    "happy.png"
  ];
  List<String> items = ["depress", "stress", "anger", 'sad', "relax", "happy"];
  List listChange = [
    Depress(),
    StressList(),
    AngerList(),
    SadList(),
    RelaxList(),
    HappyList()
  ];

  // ? function for visibility
  void _toggleVisibility() {
    setState(() {
      isVisible = !isVisible;
    });

    Timer(Duration(seconds: 5), () {
      setState(() {
        isVisible = !isVisible;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
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
      drawer: Drawer(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: MyHeaderDrawer(
                      uid: FirebaseAuth.instance.currentUser!.uid,
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                    endIndent: BorderSide.strokeAlignCenter,
                    height: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 12, 8, 0),
                    child: Text(
                      "Report",
                      style: TextStyle(
                        fontSize: 17, 
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.data_saver_off_rounded),
                    title: Text('Daily & Weekly'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DayWeekReportScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.percent_outlined),
                    title: Text("Day based"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DayBarGraphReport(),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
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
                              text: user.username,
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
              SizedBox(
                height: 50,
              ),
              Visibility(
                visible: isVisible,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.only(top: 30),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.width * 0.73,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue[50],
                    ),
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 100,
                                // childAspectRatio: 3 / 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        // physics: const BouncingScrollPhysics(),
                        // itemCount: items.length,
                        itemCount: 6,
                        // scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
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
                            child: Container(
                              height: 100,
                              child: Column(
                                children: [
                                  Container(
                                    height: 40,
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
                          );
                        }),
                  ),
                ),
              ),
              Visibility(
                visible: !isVisible,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text(
                    "Today\'s Task",
                    style: TextStyle(fontSize: 20),
                  ),
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
              Visibility(
                visible: !isVisible,
                child: Container(
                  child: listChange[current],
                ),
              )
            ]),
      ),
    );
  }
}
