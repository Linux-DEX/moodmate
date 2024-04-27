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
    barData.add(IndividualBar(x: 7, y: zeroday));
    barData.add(IndividualBar(x: 14, y: fifteenday));
    barData.add(IndividualBar(x: 21, y: thirtyday));
    barData.add(IndividualBar(x: 28, y: fortyfiveday));
    barData.add(IndividualBar(x: 35, y: sixtyday));
    barData.add(IndividualBar(x: 42, y: seventyfiveday));
  }
}
