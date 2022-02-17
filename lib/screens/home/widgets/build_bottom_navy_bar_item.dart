import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/constant.dart';

buildBottomNavyBarItem(IconData icon, String text){
  return BottomNavyBarItem(
    icon: Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
      child: Icon(
        icon,
        size: 20.w,
      ),
    ),
    title: Text(text),
    activeColor: mainColor,
    inactiveColor: Colors.black87,
  );
}