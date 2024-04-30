import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:provider/provider.dart';
import "package:moodmate/Model/user.dart" as model;
import 'package:shared_preferences/shared_preferences.dart';
import "../reusable_widgets/resetValue.dart";

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  String username = "";
  int current = 0;
  bool isVisible = true;
  // ! New
  static int _counter = 0;
  DateTime dateTime = DateTime.now();
  static int day = 0;
  bool isLoading = false;

  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt('counter') ?? dateTime.day;
      print("loadcoutner value");
      print(_counter);
      print(day);
    });
  }

  Future<void> _setCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt('counter', _counter);
      print("setcoutner value");
      print(_counter);
      print(day);
    });
  }

  Future<void> _incrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // _counter = (prefs.getInt('counter') ?? 0) + 1;
      DateTime now = DateTime.now();
      DateTime nextDay = now.add(Duration(days: 1));
      _counter = nextDay.day;
      prefs.setInt('counter', _counter);
    });
    print("Increment function");
    print(_counter);
    print(day);
  }

  void checkDay() async {
    final prefs = await SharedPreferences.getInstance();
    day = dateTime.day;
    _loadCounter();
    if (day != _counter) {
      isVisible = false;
      prefs.setBool('visible', isVisible);
      _counter = day;
      _setCounter();
      print("checkDay");
      print(_counter);
      print(day);
    } else {
      isVisible = true;
      prefs.setBool('visible', isVisible);
    }
  }

  void checkVisible() async {
    final prefs = await SharedPreferences.getInstance();
    isVisible = prefs.getBool('visible') ?? true;
  }

  void checkCurrent() async {
    final prefs = await SharedPreferences.getInstance();
    current = prefs.getInt('current') ?? 0;
  }

  // ! End new code

  @override
  void initState() {
    super.initState();
    addData();
    print("Init counter value");
    print(_counter);
    print(day);
    checkCurrent();
    checkVisible();
    checkDay();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  void getUserName() async {
    setState(() {
      isLoading = true;
    });
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      username = (snap.data() as Map<String, dynamic>)['username'];
      isLoading = false;
    });
  }

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
    Depress(
      uid: FirebaseAuth.instance.currentUser!.uid,
    ),
    StressList(
      uid: FirebaseAuth.instance.currentUser!.uid,
    ),
    AngerList(
      uid: FirebaseAuth.instance.currentUser!.uid,
    ),
    SadList(
      uid: FirebaseAuth.instance.currentUser!.uid,
    ),
    RelaxList(
      uid: FirebaseAuth.instance.currentUser!.uid,
    ),
    HappyList(
      uid: FirebaseAuth.instance.currentUser!.uid,
    )
  ];

  // ? function for visibility
  void _toggleVisibility() {
    setState(() {
      isVisible = false;
      _incrementCounter();
    });

    // Timer(Duration(seconds: 60), () {
    //   setState(() {
    //     isVisible = !isVisible;
    //     Navigator.push(
    //         context, MaterialPageRoute(builder: (context) => HomeScreen()));
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        actions: [],
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
                          decoration: TextDecoration.underline),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.data_saver_off_rounded),
                    title: Text('Daily & Weekly'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DayWeekReportScreen(
                            uid: FirebaseAuth.instance.currentUser!.uid,
                          ),
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
                          builder: (context) => DayBarGraphReport(
                            uid: FirebaseAuth.instance.currentUser!.uid,
                          ),
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
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
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
                                if (user != null && user.username != null)
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
                      height: 40,
                    ),
                    isVisible
                        ? Center(
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
                                      onTap: () async {
                                        final prefs = await SharedPreferences
                                            .getInstance();
                                        checkDayfirebase();
                                        current = index;
                                        prefs.setInt('current', index);
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
                          )
                        : Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: Text(
                                  "Today\'s Task",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              Container(
                                child: listChange[current],
                              ),
                            ],
                          )
                  ]),
            ),
    );
  }
}
