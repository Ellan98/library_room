import 'package:intl/intl.dart';

String timeStampFormat(int timestamp) {
  String date;

  try {
    date = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.fromMillisecondsSinceEpoch(timestamp));
    print(date);
  } catch (e) {
    print('Invalid timestamp: $timestamp');
    date = 'Invalid timestamp';
  }

  return date;
}
