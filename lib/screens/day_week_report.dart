import 'package:flutter/material.dart';
import 'package:moodmate/reusable_widgets/day_report.dart';
import 'package:moodmate/reusable_widgets/weekly_report.dart';

class DayWeekReportScreen extends StatefulWidget {
  const DayWeekReportScreen({super.key});

  @override
  State<DayWeekReportScreen> createState() => _DayWeekReportScreenState();
}

class _DayWeekReportScreenState extends State<DayWeekReportScreen> {
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
                DailyReport(context),
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
                WeeklyReport(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
