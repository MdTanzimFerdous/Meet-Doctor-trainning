import 'package:flutter/material.dart';

import '../../constant/constant.dart';
import '../sign_in_sign_up/widgets/custom_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorOrPatient extends StatefulWidget {
  const DoctorOrPatient({Key? key}) : super(key: key);

  @override
  _DoctorOrPatientState createState() => _DoctorOrPatientState();
}

class _DoctorOrPatientState extends State<DoctorOrPatient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 400.h,
              width: 400.w,
              child: Image.asset(
                "assets/doctor_exam_patient.png",
                fit: BoxFit.contain,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('SignUpDoctor');
              },
              //child: paintButton("Doctor"),
              child: buildButton("Doctor", 350, 20),
            ),
            SizedBox(
              height: 20.w,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed('SignUp');
              },
              child: buildButton("Patient", 350, 20),
            ),
          ],
        ),
      ),
    );
  }
}