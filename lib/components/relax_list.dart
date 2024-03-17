import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moodmate/utils.dart';

class RelaxList extends StatefulWidget {
  // const RelaxList({super.key});
  final String uid;
  const RelaxList({Key? key, required this.uid}) : super(key: key);

  @override
  State<RelaxList> createState() => _RelaxListState();
}

class _RelaxListState extends State<RelaxList> {
  List<dynamic> isChecked = [false, false, false, false, false];
  List<String> relax = [
    "Deep breaths",
    "Light a candle",
    "Read a book",
    "Stretch routine",
    "Enjoy nature"
  ];
  List<String> workout = [
    "exp1",
    "exp2",
    "exp3",
    "exp4",
    "exp5",
  ];
  List<String> image = [
    "assets/images/breath.png",
    "assets/images/candle.png",
    "assets/images/book.png",
    "assets/images/stretchroutine.png",
    "assets/images/nature.png"
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
                            relax[index],
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
                          // setState(() => isChecked[index] = !isChecked[index]);
                          setState(() => {
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
