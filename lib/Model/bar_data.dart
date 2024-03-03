import 'package:moodmate/Model/individual_bar.dart';

class BarData {
  final double zeroday;
  final double fifteenday;
  final double thirtyday;
  final double fortyfiveday;
  final double sixtyday;
  final double seventyfiveday;

  BarData({
    required this.zeroday,
    required this.fifteenday,
    required this.thirtyday,
    required this.fortyfiveday,
    required this.sixtyday,
    required this.seventyfiveday,
  });

  List<IndividualBar> barData = [];

  void initializeBarData() {
    barData.add(IndividualBar(x: 15, y: zeroday));
    barData.add(IndividualBar(x: 30, y: fifteenday));
    barData.add(IndividualBar(x: 45, y: thirtyday));
    barData.add(IndividualBar(x: 60, y: fortyfiveday));
    barData.add(IndividualBar(x: 75, y: sixtyday));
    barData.add(IndividualBar(x: 90, y: seventyfiveday));
  }
}
