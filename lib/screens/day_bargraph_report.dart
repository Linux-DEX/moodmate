import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moodmate/reusable_widgets/bar_graph.dart';

class DayBarGraphReport extends StatefulWidget {
  // const DayBarGraphReport({super.key});
  final String uid;
  const DayBarGraphReport({super.key, required this.uid});

  @override
  State<DayBarGraphReport> createState() => _DayBarGraphReportState();
}

class _DayBarGraphReportState extends State<DayBarGraphReport> {
  List<double> barGraphDayData = [0, 0, 0, 0, 0, 0];
  var userData = {};
  getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      userData = userSnap.data()!;
      barGraphDayData[0] = userData['day7'].toDouble();
      barGraphDayData[1] = userData['day14'].toDouble();
      barGraphDayData[2] = userData['day21'].toDouble();
      barGraphDayData[3] = userData['day28'].toDouble();
      barGraphDayData[4] = userData['day35'].toDouble();
      barGraphDayData[5] = userData['day42'].toDouble();
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bar Graph",
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
      ),
      body: Center(
        child: MyBarGraph(context, barGraphDayData),
      ),
    );
  }
}
