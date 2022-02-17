import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constant/constant.dart';
import 'build_show_dialog.dart';

showDialogConfirmation(BuildContext context, File image) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(
        'Update Profile!',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.w,
          color: mainColor,
        ),
      ),
      content: Padding(
        padding: EdgeInsets.all(40.w),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(360.w),
          child: Image.file(
            image,
            fit: BoxFit.cover,
            width: 200.w,
            height: 200.w,
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Cancel');
          },
          child: Text(
            'Cancel',
            style: TextStyle(
              //fontWeight: FontWeight.bold,
              fontSize: 20.w,
              color: Colors.grey,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Upload');
          },
          child: Text(
            'Upload',
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