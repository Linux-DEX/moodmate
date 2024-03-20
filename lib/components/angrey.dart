import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moodmate/utils.dart';

class AngerList extends StatefulWidget {
  // const AngerList({super.key});
  final String uid;
  const AngerList({Key? key, required this.uid}) : super(key: key);

  @override
  State<AngerList> createState() => _AngerListState();
}

class _AngerListState extends State<AngerList> {
  List<dynamic> isChecked = [false, false, false, false, false];
  List<String> anger = [
    "Count to 10",
    "Squeeze a stress ball",
    "Punch a pillow",
    "Color in book",
    "Do jumping jacks"
  ];
  List<String> workout = [
    "exp1",
    "exp2",
    "exp3",
    "exp4",
    "exp5",
  ];
  List<String> image = [
    "assets/images/count.png",
    "assets/images/squeezeball.png",
    "assets/images/pillow.png",
    "assets/images/colorbook.png",
    "assets/images/jumpingjack.png"
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
      if (temp.exists) {
        tempVal = temp.get('mood.${formattedDate.toLowerCase()}.anger');
      }
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'mood.${formattedDate.toLowerCase()}.anger': (tempVal! + 1)});
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
                            anger[index],
                            style: TextStyle(fontSize: 20),
                            overflow: TextOverflow.ellipsis,
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
                          // setState(() => isChecked[index] = !isChecked[index]);
                          setState(() => {
                                isChecked[index] = !isChecked[index],
                                setUserTasks(isChecked),
                                print(userData['todaytask']),
                                if (isChecked[index] == true)
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
