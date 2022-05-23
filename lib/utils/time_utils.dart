import 'package:intl/intl.dart';

class TimeUtil {
  static newMessageTime(DateTime date) {
    // Make a fuzzy time
    DateTime now = DateTime.now();
    DateTime nowDate = DateTime(now.year, now.month, now.day);
    DateTime yesterdayDate = nowDate.subtract(Duration(days: 1));
    DateTime givenDate = DateTime(date.year, date.month, date.day);

    DateFormat timeFormate = DateFormat('jm');
    DateFormat dateFormate = DateFormat('dd MMM');

    if (nowDate == givenDate) {
      return timeFormate.format(date);
    } else if (yesterdayDate == givenDate) {
      return 'Yesterday at ${timeFormate.format(date)}';
    } else {
      return '${dateFormate.format(date)} at ${timeFormate.format(date)}';
    }
  }
}
