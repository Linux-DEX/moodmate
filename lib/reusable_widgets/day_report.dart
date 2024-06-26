import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

Container DailyReport(BuildContext context, double perc) {
  double percentage = perc ?? 0;

  return Container(
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "assets/icons/sad.png",
            height: 20,
            color: Colors.redAccent,
          ),
        ),
        LinearPercentIndicator(
          width: MediaQuery.of(context).size.width - 98,
          animation: true,
          lineHeight: 20.0,
          animationDuration: 1000,
          percent: percentage < 0 ? 0 : percentage / 100,
          progressColor: (percentage / 100 < 0.5
              ? Colors.redAccent.shade200
              : Colors.blueAccent.shade200),
          barRadius: Radius.circular(10),
          center: Text(percentage.toString()),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.emoji_emotions_outlined,
            color: Colors.blueAccent,
          ),
        ),
      ],
    ),
  );
}
