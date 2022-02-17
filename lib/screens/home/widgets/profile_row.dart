import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constant/constant.dart';

profileRow(String hintText, String relatedInfo, BuildContext context) {
  return Padding(
    padding: EdgeInsets.fromLTRB(20.0.h, 7.0.h, 20.0.h, 7.0.h),
    child: Row(
      children: [
        Text(
          "$hintText:",
          style: TextStyle(
            color: liteGrey,
            fontWeight: FontWeight.bold,
            fontSize: 15.h,
          ),
        ),
        const Spacer(),
        Text(
          relatedInfo,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: liteColor,
            fontSize: 15.h,
          ),
        ),
        const Icon(
          FontAwesomeIcons.angleRight,
          color: liteGrey,
          //size: 15,
        ),
      ],
    ),
  );
}