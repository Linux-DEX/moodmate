import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

Container DailyReport(BuildContext context) {
  return Container(
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.emoji_emotions_outlined),
        ),
        // Container(
        //     margin: EdgeInsets.symmetric(vertical: 20),
        //     width: 300,
        //     height: 20,
        //     child: ClipRRect(
        //       borderRadius: BorderRadius.all(Radius.circular(10)),
        //       child: LinearProgressIndicator(
        //         value: 0.6,
        //         valueColor: AlwaysStoppedAnimation<Color>(Color(0xff00ff00)),
        //         backgroundColor: Color(0xffD6D6D6),
        //       ),
        //     ),
        //   ),
        LinearPercentIndicator(
          width: MediaQuery.of(context).size.width - 98,
          animation: true,
          lineHeight: 20.0,
          animationDuration: 2000,
          percent: 0.8,
          progressColor: Colors.blueAccent.shade200,
          barRadius: Radius.circular(10),
          center: Text("80%"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.emoji_emotions_rounded),
        ),
      ],
    ),
  );
}
