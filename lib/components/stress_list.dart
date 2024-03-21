import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moodmate/utils.dart';

class StressList extends StatefulWidget {
  // const StressList({super.key});
  final String uid;
  const StressList({Key? key, required this.uid}) : super(key: key);

  @override
  State<StressList> createState() => StressListState();
}

class StressListState extends State<StressList> {
  List<dynamic> isChecked = [false, false, false, false, false];
  List<String> stress = [
    "5-min meditation",
    "Tidy your workspace",
    "Make a to-do list",
    "Listen calming music",
    "Do some cleaning"
  ];
  List<String> workout = [
    "exp1",
    "exp2",
    "exp3",
    "exp4",
    "exp5",
  ];
  List<String> image = [
    "assets/images/meditation.png",
    "assets/images/tidyworkspace.png",
    "assets/images/todolist.png",
    "assets/images/listenmusic.png",
    "assets/images/cleaning.png",
  ];

  int limitValue = 0;
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

  setUserMoodValue() async {
       String userId = FirebaseAuth.instance.currentUser!.uid;
    int? tempVal;

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE').format(now);
    print(formattedDate);

    try {
      var temp = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      limitValue = temp.get('moodValue.stress');
      if (temp.exists) {
        tempVal = temp.get('moodValue.stress');
      }
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'moodValue.stress': (tempVal! + 1)});
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'dayMood.${formattedDate.toLowerCase()}': "stress"});
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
                            stress[index],
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
                          // * this is another way of checkbox
                          // setState(() => {
                          //       isChecked[index] = newValue ?? false,
                          //     });
                          setState(() => {
                                isChecked[index] = !isChecked[index],
                                setUserTasks(isChecked),
                                print(userData['todaytask']),
                                if (isChecked[index] == true && limitValue < 4)
                                  {
                                    setUserMoodValue(),
                                  }
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
