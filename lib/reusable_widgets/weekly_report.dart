import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

Column circular(int percentage, String day, String mood, Color colorOne) {
  double per = percentage / 100;
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
            // percent: 0.4,
            percent: per,
            // progressColor: Colors.blueAccent.shade200,
            progressColor: colorOne,
            backgroundColor: const Color.fromARGB(255, 195, 213, 242),
            circularStrokeCap: CircularStrokeCap.round,
            // center: Text(
            //   percentage.toStringAsFixed(0) + "%",
            //   style: TextStyle(
            //       fontSize: 20,
            //       color: Colors.blueAccent,
            //       fontWeight: FontWeight.w500),
            // ),
            center: Icon(
              Icons.accessibility_new_rounded,
              color: Colors.blueAccent,
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

// Container WeeklyReport(BuildContext context) {
//   return Container(
//     child: Expanded(
//         child: GridView.count(
//       crossAxisCount: 4,
//       // mainAxisSpacing: 10,
//       // crossAxisSpacing: 10,
//       childAspectRatio: 7 / 10,
//       children: [
//         circular(10, "monday", "Happy", Colors.redAccent.shade400),
//         circular(30, "TUE", "relax", Colors.orangeAccent.shade400),
//         circular(40, "WED", "Sad", Colors.yellowAccent.shade400),
//         circular(80, "THUR", "Happy", Colors.greenAccent.shade400),
//         circular(30, "FRI", "Sad", Colors.blueAccent.shade400),
//         circular(40, "SAT", "Sad", Colors.indigoAccent.shade400),
//         circular(90, "SUN", "Happy", Colors.deepPurpleAccent.shade400),
//       ],
//     )),
//   );
// }

class WeeklyReportClass extends StatefulWidget {
  const WeeklyReportClass({super.key});

  @override
  State<WeeklyReportClass> createState() => _WeeklyReportClassState();
}

class _WeeklyReportClassState extends State<WeeklyReportClass> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
          child: GridView.count(
        crossAxisCount: 4,
        // mainAxisSpacing: 10,
        // crossAxisSpacing: 10,
        childAspectRatio: 7 / 10,
        children: [
          circular(10, "monday", "Happy", Colors.redAccent.shade400),
          circular(30, "TUE", "relax", Colors.orangeAccent.shade400),
          circular(40, "WED", "Sad", Colors.yellowAccent.shade400),
          circular(80, "THUR", "Happy", Colors.greenAccent.shade400),
          circular(30, "FRI", "Sad", Colors.blueAccent.shade400),
          circular(40, "SAT", "Sad", Colors.indigoAccent.shade400),
          circular(90, "SUN", "Happy", Colors.deepPurpleAccent.shade400),
        ],
      )),
    );
  }
}
