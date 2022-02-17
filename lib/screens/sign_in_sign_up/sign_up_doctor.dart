import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meet_doctor_training/screens/sign_in_sign_up/widgets/custom_button.dart';
import 'package:meet_doctor_training/screens/sign_in_sign_up/widgets/custom_text_field.dart';
import 'package:meet_doctor_training/screens/sign_in_sign_up/widgets/snackbar.dart';
import 'package:meet_doctor_training/screens/sign_in_sign_up/widgets/top.dart';

import 'package:provider/provider.dart';

import '../../constant/constant.dart';
import '../../provider/authentication.dart';
import '../../provider/sign_up_provider.dart';

class SignUpDoctor extends StatefulWidget {
  const SignUpDoctor({Key? key}) : super(key: key);

  @override
  _SignUpDoctorState createState() => _SignUpDoctorState();
}

class _SignUpDoctorState extends State<SignUpDoctor> {
  String dropdownValue = 'Allergists';

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController bmdcRegController = TextEditingController();
  TextEditingController nidController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController specializationController = TextEditingController();
  TextEditingController feeController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.clear();
    emailController.clear();
    confirmPasswordController.clear();
    contactController.clear();
    bmdcRegController.clear();
    nidController.clear();
    designationController.clear();
    specializationController.clear();
    feeController.clear();
    dayController.clear();
    timeController.clear();
    locationController.clear();

    super.dispose();
  }

  validate() async {
    print(dropdownValue);
    if (_formKey.currentState!.validate()) {
      try {
        buildShowDialog(context);
        Provider.of<Authentication>(context, listen: false)
            .signUpDoctor(
          name: nameController.text,
          email: emailController.text,
          password: confirmPasswordController.text,
          context: context,
          contact: contactController.text,
          bmdcReg: bmdcRegController.text,
          nid: nidController.text,
          //designation: designationController.text,
          designation: dropdownValue,
          specialization: specializationController.text,
          fee: feeController.text,
          day: dayController.text,
          time: timeController.text,
          location: locationController.text,
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
                child: SingleChildScrollView(
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
                            customTextField(
                              contactController,
                              "Enter contact number",
                              false,
                              context,
                            ),
                            customTextField(
                              bmdcRegController,
                              "Enter BMDC Registration number",
                              false,
                              context,
                            ),
                            customTextField(
                              nidController,
                              "Enter your NID",
                              false,
                              context,
                            ),
                            /*customTextField(
                              designationController,
                              "Enter your designation",
                              false,
                              context,
                            ),*/

                            customTextField(
                              specializationController,
                              "Enter your specialization",
                              false,
                              context,
                            ),
                            customTextField(
                              feeController,
                              "Enter your fee",
                              false,
                              context,
                            ),
                            customTextField(
                              dayController,
                              "Enter day. Ex: SAT - SUN",
                              false,
                              context,
                            ),
                            customTextField(
                              timeController,
                              "Enter time. Ex: 4pm - 8pm",
                              false,
                              context,
                            ),
                            customTextField(
                              locationController,
                              "Enter your location",
                              false,
                              context,
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(40.w, 10.w, 40.w, 10.w),
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: Container(
                                  height: 58,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.white,
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    isDense: true,
                                    isExpanded: true,
                                    value: dropdownValue,
                                    icon: const Icon(
                                      FontAwesomeIcons.angleDown,
                                      color: mainColor,
                                    ),
                                    dropdownColor: Colors.white,

                                    elevation: 16,
                                    style: const TextStyle(color: mainColor),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),

                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownValue = newValue!;
                                      });
                                    },
                                    items: <String>[
                                      'Allergists',
                                      'Cardiologists',
                                      'Dermatologists',
                                      'General surgeons',
                                      'Gynecologists',
                                      'Nephrologists',
                                      'Neurologists',
                                      'Orthopedic surgeons',
                                      'Pediatricians',
                                      'Psychiatrists',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
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
                          ),
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
                      SizedBox(height: 300.h),
                    ],
                  ),
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