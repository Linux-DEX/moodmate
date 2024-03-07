import 'package:flutter/material.dart';
import 'package:moodmate/reusable_widgets/bar_graph.dart';

class DayBarGraphReport extends StatefulWidget {
  const DayBarGraphReport({super.key});

  @override
  State<DayBarGraphReport> createState() => _DayBarGraphReportState();
}

class _DayBarGraphReportState extends State<DayBarGraphReport> {
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
        child: MyBarGraph(context),
      ),
    );
  }
}
