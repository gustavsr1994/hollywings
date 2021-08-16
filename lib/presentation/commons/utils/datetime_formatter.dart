import 'package:intl/intl.dart';

class DatetimeFormatter {
  String formatDate(String date) {
    var result = DateFormat('yyyy-MM-dd').parse(date);
    var output = DateFormat('dd MMM yyyy');
    return output.format(result);
  }

  String formatDatePicker(DateTime date) {
    var output = DateFormat('dd MMM yyyy');
    return output.format(date);
  }

  String formatBackendDate(String date) {
    var result = DateFormat('dd MMM yyyy').parse(date);
    var output = DateFormat('yyyy-MM-dd');
    return output.format(result);
  }

  String formatDatePickerYear(DateTime date) {
    var output = DateFormat('yyyy');
    return output.format(date);
  }
}
