import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moodmate/reusable_widgets/day_report.dart';
import 'package:moodmate/reusable_widgets/weekly_report.dart';

class DayWeekReportScreen extends StatefulWidget {
  final String uid;
  const DayWeekReportScreen({super.key, required this.uid});

  @override
  State<DayWeekReportScreen> createState() => _DayWeekReportScreenState();
}

class _DayWeekReportScreenState extends State<DayWeekReportScreen> {
  double dayPercentage = 0;
  String previousDayName = "";
  bool isLoading = false;

  var userData = {};
  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      DateTime now = DateTime.now();
      previousDayName = DateFormat('EEEE').format(now).toLowerCase();
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      userData = userSnap.data()!;
      print(previousDayName);
      print(userData['dayMood']![previousDayName]);
      String temp = userData['dayMood']![previousDayName];
      int value = userData['moodValue']![previousDayName]![temp];
      dayPercentage = (value * 100) / 5;
      setState(() {});
    } catch (e) {
      print("Error : ${e}");
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Daily and Weekly Report",
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
      ),
      body: SafeArea(
        child: SafeArea(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 2, 1, 10),
                  child: Text(
                    "Daily Report",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                DailyReport(context, dayPercentage),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 2, 10, 10),
                  child: Text(
                    "Weekly Report",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                isLoading ? 
                const Center(
                  child: CircularProgressIndicator(),
                )
                : WeeklyReportClass(uid: widget.uid),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
