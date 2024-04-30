import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

Column circular(int percentage, String day, String mood, Color colorOne) {
  double per = percentage / 100;
  Map<String, String> emoji = {
    "depress": 'assets/icons/depressemoji.png',
    "stress": 'assets/icons/stressemoji.png',
    "anger": 'assets/icons/angryemoji.png',
    "sad": 'assets/icons/sademoji.png',
    "relax": 'assets/icons/relaxemoji.png',
    "happy": 'assets/icons/happyemoji.png',
  };
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.fromLTRB(2, 1, 2, 1),
        child: Text(
          day,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          child: CircularPercentIndicator(
            animation: true,
            animationDuration: 1000,
            radius: 30,
            lineWidth: 10,
            percent: per,
            progressColor: colorOne,
            backgroundColor: const Color.fromARGB(255, 195, 213, 242),
            circularStrokeCap: CircularStrokeCap.round,
            center: Center(
              child: Image.asset(
                // 'assets/icons/happyemoji.png',
                emoji[mood] ?? 'assets/icons/empty.png',
                height: 20,
                width: 20,
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(2, 1, 2, 1),
        child: Text(
          percentage.toString() + "%",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    ],
  );
}


class WeeklyReportClass extends StatefulWidget {
  // const WeeklyReportClass({super.key});
  final String uid;
  const WeeklyReportClass({super.key, required this.uid});

  @override
  State<WeeklyReportClass> createState() => _WeeklyReportClassState();
}

class _WeeklyReportClassState extends State<WeeklyReportClass> {
  var userData = {};
  // int dayPercOne = 0;
  List<int> dayPerc = [0, 0, 0, 0, 0, 0, 0];
  getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      userData = userSnap.data()!;
      dayPerc[0] =
          userData['moodValue']!['monday']![userData['dayMood']!['monday']] ??
              0;
      dayPerc[1] =
          userData['moodValue']!['tuesday']![userData['dayMood']!['tuesday']] ??
              0;
      dayPerc[2] = userData['moodValue']!['wednesday']![
              userData['dayMood']!['wednesday']] ??
          0;
      dayPerc[3] = userData['moodValue']!['thursday']![
              userData['dayMood']!['thursday']] ??
          0;
      dayPerc[4] =
          userData['moodValue']!['friday']![userData['dayMood']!['friday']] ??
              0;
      dayPerc[5] = userData['moodValue']!['saturday']![
              userData['dayMood']!['saturday']] ??
          0;
      dayPerc[6] =
          userData['moodValue']!['sunday']![userData['dayMood']!['sunday']] ??
              0;
      print(dayPerc);
      setState(() {});
    } catch (e) {
      // showSnackBar(e.toString(), context);
      print("Error : ${e}");
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
          child: GridView.count(
        crossAxisCount: 4,
        childAspectRatio: 7 / 10,
        children: [
          circular(
              ((dayPerc[0] / 5) * 100).toInt(),
              "MON",
              userData['dayMood']!['monday'] ?? "string",
              Colors.redAccent.shade400),
          circular(
              ((dayPerc[1] / 5) * 100).toInt(),
              "TUE",
              userData['dayMood']!['tuesday'] ?? "string",
              Colors.orangeAccent.shade400),
          circular(
              ((dayPerc[2] / 5) * 100).toInt(),
              "WED",
              userData['dayMood']!['wednesday'] ?? "string",
              Colors.yellowAccent.shade400),
          circular(
              ((dayPerc[3] / 5) * 100).toInt(),
              "THUR",
              userData['dayMood']!['thursday'] ?? "string",
              Colors.greenAccent.shade400),
          circular(
              ((dayPerc[4] / 5) * 100).toInt(),
              "FRI",
              userData['dayMood']!['friday'] ?? "string",
              Colors.blueAccent.shade400),
          circular(
              ((dayPerc[5] / 5) * 100).toInt(),
              "SAT",
              userData['dayMood']!['saturday'] ?? "string",
              Colors.indigoAccent.shade400),
          circular(
              ((dayPerc[6] / 5) * 100).toInt(),
              "SUN",
              userData['dayMood']!['sunday'] ?? "string",
              Colors.deepPurpleAccent.shade400),
        ],
      )),
    );
  }
}
