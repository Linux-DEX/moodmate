import 'package:intl/intl.dart';

main() {
  DateTime now = DateTime.now();

  // Calculate previous day's date
  DateTime previousDay = now.subtract(Duration(days: 1));

  // Format the date to display day name (Monday, Tuesday, etc.)
  String previousDayName = DateFormat('EEEE').format(previousDay);

  print(previousDayName);
}
