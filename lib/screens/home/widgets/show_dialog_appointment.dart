import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constant/constant.dart';
import 'build_show_dialog.dart';

showDialogAppointment(BuildContext context, String uid) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(
        'Appointment done!',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.w,
          color: mainColor,
        ),
      ),
      content: Padding(
        padding: EdgeInsets.all(40.w),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0.w),
          child: Text(
            'Visit your doctor on time. Thank you.',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.w,
            ),
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Ok');
          },
          child: Text(
            'Ok',
            style: TextStyle(
              //fontWeight: FontWeight.bold,
              fontSize: 20.w,
              color: mainColor,
            ),
          ),
        ),
      ],
    ),
  );
}