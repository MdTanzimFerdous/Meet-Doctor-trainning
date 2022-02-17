import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meet_doctor_training/screens/sign_in_sign_up/widgets/custom_button.dart';
import 'package:meet_doctor_training/screens/sign_in_sign_up/widgets/custom_text_field.dart';
import 'package:meet_doctor_training/screens/sign_in_sign_up/widgets/snackbar.dart';


import 'package:provider/provider.dart';

import '../../constant/constant.dart';
import '../../provider/authentication.dart';
import '../../provider/sign_up_provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.clear();
    passwordController.clear();
    super.dispose();
  }

  validate() async {
    /*Navigator.of(context).pop(); // testing...*/
    if (_formKey.currentState!.validate()) {
      try {
        buildShowDialog(context); //bar bar ghure
        Provider.of<Authentication>(context, listen: false)
            .signIn(emailController.text, passwordController.text, context)
            .then(
          (value) {
            if (value != "Success") {
              snackBar(context, value);
            }
          },
        );
      } catch (e) {
        // ignored....
      }
    }
  }

  buildShowDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(color: Colors.brown),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(
        backgroundColor: mainBackColor,
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                width: 414.w,
                height: 837.h - statusBarHeight,
                child: Column(
                  children: [
                    SizedBox(height: 100.h),
                    Text(
                      "Welcome Back!",
                      style: GoogleFonts.rubik(
                        fontSize: 35.sp,
                        color: mainColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 25.h),
                    SizedBox(
                      height: 280.h,
                      width: 344.w,
                      child: Image.asset("assets/sign_in.png"),
                    ),
                    SizedBox(height: 25.h),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          customTextField(
                            emailController,
                            "Email Address",
                            false,
                            context,
                          ),
                          Consumer<SignUpProvider>(
                            builder: (context, provider, child) {
                              return customTextField(
                                passwordController,
                                "Password (6 or more digits)",
                                true,
                                context,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 37.w, top: 8.h),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('PasswordReset');
                          },
                          child: Text(
                            "Forgot Password?",
                            style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                color: mainColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    InkWell(
                      onTap: () {
                        validate();
                      },
                      child: buildButton("Sign In", 350.w, 20.h),
                    ),
                    SizedBox(height: 15.h),
                    switchPageButton(
                      "Don’t have an account? - ",
                      "Sign Up",
                      context,
                    ),
                  ],
                ),
              ),
            ),
            // top(context, "SignIn"),
          ],
        ),
      ),
    );
  }
}
