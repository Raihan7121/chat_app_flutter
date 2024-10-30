import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class MyDateUtil {
  //for getting formatted time frjom millisecondsSince string
  static String getFormattedTime(
    {required BuildContext context,required String time}){
      final date = DateTime.fromMicrosecondsSinceEpoch(int.parse(time));

    return TimeOfDay.fromDateTime(date).format(context);
  }

   //for getting formatted time frjom millisecondsSince string
  static String getLastMessageTime(
    {required BuildContext context,required String time}){
      final DateTime sent = DateTime.fromMicrosecondsSinceEpoch(int.parse(time));

      final DateTime now = DateTime.now();

      if(now.day == sent.day && now.month == sent.month && now.year == sent.year){
        return TimeOfDay.fromDateTime(sent).format(context);
      }

    return '${sent.day} ${_getMonth(sent)}';
  }

  //get month name from month no. or index
  static String _getMonth(DateTime date){
    return DateFormat('MMM').format(date);
  }
}