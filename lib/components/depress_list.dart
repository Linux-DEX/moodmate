// ? to store the data when ever the page is changed we can use shared_preference package. or directly we can save the data in firebase
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moodmate/utils.dart';

class Depress extends StatefulWidget {
  // const Depress({super.key});
  final String uid;
  const Depress({Key? key, required this.uid}) : super(key: key);

  @override
  State<Depress> createState() => _DepressState();
}

class _DepressState extends State<Depress> {
  List<dynamic> isChecked = [false, false, false, false, false];
  List<String> depress = [
    "Get some sunlight",
    "Do a small chore",
    "Listen to music",
    "Watch a movie",
    "Take a walk outside"
  ];
  List<String> workout = [
    "exp1",
    "exp2",
    "exp3",
    "exp4",
    "exp5",
  ];
  List<String> image = [
    "assets/images/sunlight.png",
    "assets/images/cleaning.png",
    "assets/images/listenmusic.png",
    "assets/images/movie.png",
    "assets/images/walkoutside.png"
  ];

  var userData = {};
  getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      userData = userSnap.data()!;
      setState(() {
        isChecked = userData['todaytask'];
        print(userData['todaytask']);
        print("ischeck value: $isChecked");
      });
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  setUserTasks(List<dynamic> tasks) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'todaytask': tasks});

      print("updated successfully");
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) => Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
          child: Card(
            elevation: 5.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 50.0,
                        height: 50.0,
                        color: Colors.transparent,
                        child: Image.asset(image[index]),
                      ),
                      SizedBox(width: 5.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            depress[index],
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(workout[index]),
                        ],
                      )
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Checkbox(
                        value: isChecked[index],
                        onChanged: (newValue) {
                          setState(
                              () => {
                                isChecked[index] = !isChecked[index],
                                setUserTasks(isChecked),
                                print(userData['todaytask']),
                              });
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
