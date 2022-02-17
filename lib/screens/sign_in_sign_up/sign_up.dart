import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meet_doctor_training/screens/sign_in_sign_up/widgets/custom_button.dart';
import 'package:meet_doctor_training/screens/sign_in_sign_up/widgets/custom_text_field.dart';
import 'package:meet_doctor_training/screens/sign_in_sign_up/widgets/snackbar.dart';
import 'package:meet_doctor_training/screens/sign_in_sign_up/widgets/top.dart';

import 'package:provider/provider.dart';

import '../../constant/constant.dart';
import '../../provider/authentication.dart';
import '../../provider/sign_up_provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.clear();
    emailController.clear();
    super.dispose();
  }

  validate() async {
    if (_formKey.currentState!.validate()) {
      try {
        buildShowDialog(context);
        Provider.of<Authentication>(context, listen: false)
            .signUp(
          name: nameController.text,
          email: emailController.text,
          password: confirmPasswordController.text,
          context: context,
        )
            .then(
          (value) async {
            if (value != "Success") {
              snackBar(context, value);
            } else {
              final User? user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                user.sendEmailVerification();
              }
            }
          },
        );
      } catch (e) {
        // ignored...
      }
    }
  }

  buildShowDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(color: mainColor),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    var pro = Provider.of<SignUpProvider>(context, listen: false);

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
                      "Welcome!",
                      style: GoogleFonts.rubik(
                        fontSize: 45.sp,
                        color: mainColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    SizedBox(height: 28.h),
                    Padding(
                      padding: EdgeInsets.only(left: 37.w),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "* Please Provide Valid Information",
                          style: GoogleFonts.rubik(
                            fontSize: 13.sp,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          customTextField(
                            nameController,
                            "Enter your name",
                            false,
                            context,
                          ),
                          customTextField(
                            emailController,
                            "Email Address",
                            false,
                            context,
                          ),
                          Consumer<SignUpProvider>(
                            builder: (context, provider, child) {
                              return customTextField(
                                pro.passwordController,
                                "Password (6 or more digits)",
                                true,
                                context,
                              );
                            },
                          ),
                          customTextField(
                            confirmPasswordController,
                            "Confirm Password",
                            false,
                            context,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(width: 22.w),
                        Consumer<SignUpProvider>(
                          builder: (context, provider, child) {
                            return Checkbox(
                              activeColor: Colors.greenAccent,
                              checkColor: Colors.white,
                              fillColor:
                                  MaterialStateProperty.resolveWith(getColor),
                              value: provider.isChecked,
                              onChanged: (bool? value) {
                                provider.changeCheckBox();
                              },
                            );
                          },
                        ),
                        Text(
                          "I agree to the Terms and Conditions",
                          style: GoogleFonts.rubik(
                            fontSize: 14.sp,
                            color: mainColor.withOpacity(0.8),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10.h),
                    InkWell(
                      onTap: () {
                        if (pro.isChecked) {
                          validate();
                        } else {
                          snackBar(context, "You have to agree to continue");
                        }
                      },
                      child: buildButton("Sign Up", 350, 20),
                    ),
                    SizedBox(height: 15.h),
                    switchPageButton(
                        "Already have an account? - ", "Sign In", context),
                  ],
                ),
              ),
            ),
            top(context, "SignIn"),
          ],
        ),
      ),
    );
  }
}

Color getColor(Set<MaterialState> states) {
  return mainColor;
}
