import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constant/constant.dart';

Stack paintButton(String text){
  return Stack(
    children: [
      SizedBox(
        height: 100.h,
        width: 350.w,
        child: Image.asset(
          "assets/painting_noback.png",
          fit: BoxFit.fill,
        ),
      ),
      Positioned(
        bottom: 32.h,
        right: 130.w,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
}

Container buildButton(String text,double width,double size) {
  return Container(
    height: 56.h,
    width: width.w,
    decoration: BoxDecoration(
      color: mainColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: size.sp,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}

Container buildOutlineButton(String text) {
  return Container(
    height: 56.h,
    width: 350.w,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: const Color(0xff7B7878)),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20.sp,
          color: const Color(0xff151238),
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

Row switchPageButton(String text1, String text2,BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        text1,
        style: GoogleFonts.rubik(
          fontSize: 15.sp,
          color: mainColor.withOpacity(0.8),
        ),
      ),
      InkWell(
        onTap: () {
          if (text2 == "Sign Up") {
            Navigator.of(context).pushReplacementNamed("DoctorOrPatient");
          } else {
            Navigator.of(context).pushReplacementNamed("SignIn");
          }
        },
        child: Text(
          text2,
          style: GoogleFonts.rubik(
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
            color: mainColor.withOpacity(0.8),
          ),
        ),
      ),
    ],
  );
}
