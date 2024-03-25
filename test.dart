import 'package:intl/intl.dart';

main() {
  DateTime now = DateTime.now();
  // DateTime previousDay = now.subtract(Duration(days: 1));
  String today = DateFormat('EEEE').format(now).toLowerCase();
  print(today);
}
