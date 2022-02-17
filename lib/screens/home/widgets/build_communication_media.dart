import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/constant.dart';

buildCommunicationMedia(String email, String contact) {
  return Padding(
    padding: EdgeInsets.fromLTRB(15.0.w, 0.0.w, 15.0.w, 0.0.w),
    child: SizedBox(
      height: 150.w,
      width: double.infinity,
      child: Card(
        elevation: 0.0,
        child: Column(
          children: [
            SizedBox(
              height: 20.w,
            ),
            Center(
              child: Text(
                "Communication Media",
                style: TextStyle(
                  fontSize: 20.w,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 20.w,
            ),

            Row(
              children: [
                Text(
                  "Contact:",
                  style: TextStyle(
                    fontSize: 17.w,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                Text(
                  contact,
                  style: TextStyle(
                    fontSize: 17.w,
                    fontWeight: FontWeight.bold,
                    color: mainColor,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Email:",
                  style: TextStyle(
                    fontSize: 17.w,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                Text(
                  email,
                  style: TextStyle(
                    fontSize: 17.w,
                    fontWeight: FontWeight.bold,
                    color: mainColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
