import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meet_doctor_training/screens/sign_in_sign_up/widgets/custom_button.dart';
import 'package:meet_doctor_training/screens/sign_in_sign_up/widgets/top.dart';

import 'package:provider/provider.dart';

import '../../constant/constant.dart';
import '../../provider/authentication.dart';
import '../home/wait_for_data.dart';

class VerificationAndHomeScreen extends StatefulWidget {
  const VerificationAndHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _VerificationAndHomeScreenState createState() =>
      _VerificationAndHomeScreenState();
}

class _VerificationAndHomeScreenState extends State<VerificationAndHomeScreen> {
  bool isVerified = false;
  bool isLoading = false;

  Future checkVerification() async {
    setState(() {
      isLoading = true;
    });

    User? user = FirebaseAuth.instance.currentUser;
    await user!.reload();
    user = FirebaseAuth.instance.currentUser;
    isVerified = user!.emailVerified;

    if (!isVerified) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Not verified yet',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
          duration: Duration(seconds: 4),
          backgroundColor: Color(0xffEF4F4F),
        ),
      );
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  sendVerificationLink() {
    final User? user = FirebaseAuth.instance.currentUser;
    user!.sendEmailVerification();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Verification mail sent',
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 1),
        backgroundColor: Color(0xff50CB93),
      ),
    );
  }

  @override
  void initState() {
    final User? user = FirebaseAuth.instance.currentUser;
    user!.sendEmailVerification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    return isLoading
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: mainColor),
            ),
          )
        : isVerified
            ? const WaitForData() // change it
            : _buildScaffold();
  }

  SafeArea _buildScaffold() {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                width: 414.w,
                height: 837.h - statusBarHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Check your email",
                      style: GoogleFonts.rubik(
                        fontSize: 25.sp,
                        color: mainColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 13.h),
                    SizedBox(
                      width: 300.w,
                      child: Text(
                        "We have sent a password recover instructions to your email",
                        style: GoogleFonts.rubik(
                          fontSize: 14.sp,
                          color: mainColor,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 25.h),
                    InkWell(
                      onTap: () {
                        checkVerification();
                      },
                      child: buildButton("Check Verification", 270, 17),
                    ),
                    SizedBox(height: 15.h),
                    InkWell(
                      onTap: () {
                        sendVerificationLink();
                      },
                      child: Text(
                        "Resend code",
                        style: GoogleFonts.rubik(
                          fontSize: 15.sp,
                          color: mainColor,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            top(context, "SignUp"),
            Positioned(
              bottom: 30,
              child: SizedBox(
                width: 414.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Did not receive the email? Check your spam folder,",
                      style: GoogleFonts.rubik(
                        fontSize: 15.sp,
                        color: mainColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("or "),
                        InkWell(
                          onTap: () {
                            Provider.of<Authentication>(
                              context,
                              listen: false,
                            ).deleteUser();

                            Navigator.of(context)
                                .pushReplacementNamed("SignUp");
                          },
                          child: Text(
                            "Try another email address",
                            style: GoogleFonts.rubik(
                              fontSize: 15.sp,
                              color: mainColor,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}