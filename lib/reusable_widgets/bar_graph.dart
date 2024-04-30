import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:moodmate/Model/bar_data.dart';

Container MyBarGraph(BuildContext context, List<double> barGraphDayData) {

  BarData myBarData = BarData(
    zeroday: barGraphDayData[0],
    fifteenday: barGraphDayData[1],
    thirtyday: barGraphDayData[2],
    fortyfiveday: barGraphDayData[3],
    sixtyday: barGraphDayData[4],
    seventyfiveday: barGraphDayData[5],
  );

  myBarData.initializeBarData();

  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
    child: SizedBox(
      height: 250,
      child: BarChart(
        BarChartData(
          maxY: 100,
          minY: 0,
          barGroups: myBarData.barData
              .map((data) => BarChartGroupData(x: data.x, barRods: [
                    BarChartRodData(
                        toY: data.y, 
                        color: Colors.blueAccent.shade400,
                        width: 15,
                        borderRadius: BorderRadius.circular(4),
                      )
                  ]))
              .toList(),
        ),
      ),
    ),
  );
}
