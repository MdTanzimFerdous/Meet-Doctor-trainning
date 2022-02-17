import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/constant.dart';

customSearchBox(BuildContext context) {
  TextEditingController searchName = TextEditingController();

  return TextFormField(
    controller: searchName,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 10.w),
      focusedBorder: const OutlineInputBorder(
        //borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: mainColor,
        ),
      ),
      prefixIcon: Icon(
        Icons.search,
        size: 35.w,
      ),
      hintText: 'Search...',
      border: const OutlineInputBorder(
        gapPadding: 0,
      ),
    ),
  );
}
