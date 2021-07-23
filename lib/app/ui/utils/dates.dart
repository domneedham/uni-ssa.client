import 'package:intl/intl.dart';

abstract class Dates {
  static String formatUI(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }
}
