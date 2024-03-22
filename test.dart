import 'package:intl/intl.dart';

main() {
  DateTime now = DateTime.now();

  // Calculate previous day's date
  DateTime nextDay = now.add(Duration(days: 1));

  print(nextDay.day);
}
