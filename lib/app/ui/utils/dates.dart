import 'package:intl/intl.dart';

abstract class Dates {
  /// Returns the [date] to a common standard for use in the UI.
  static String formatUI(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }
}
