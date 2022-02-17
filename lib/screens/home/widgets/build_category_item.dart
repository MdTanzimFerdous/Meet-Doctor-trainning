import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/constant.dart';

buildCategoryItem(String name, String image) {
  return SizedBox(
    height: 250.h,
    width: 250.w,
    child: Card(
      margin: EdgeInsets.fromLTRB(0.0.w, 20.0.w, 20.0.w, 20.0.w),
      child: Column(
        children: [
          SizedBox(
            height: 10.w,
          ),
          Image.asset(
            "assets/$image",
            height: 150.w,
            width: 150.w,
          ),
          SizedBox(
            height: 10.w,
          ),
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0.h,
              color: mainColor,
            ),
          ),
        ],
      ),
    ),
  );
}
