import 'package:flutter/material.dart';
import 'package:meet_doctor_training/screens/sign_in_sign_up/widgets/custom_button.dart';
import 'package:meet_doctor_training/screens/sign_in_sign_up/widgets/custom_text_field.dart';
import 'package:meet_doctor_training/screens/sign_in_sign_up/widgets/snackbar.dart';
import 'package:meet_doctor_training/screens/sign_in_sign_up/widgets/top.dart';

import 'package:provider/provider.dart';

import '../../constant/constant.dart';
import '../../provider/authentication.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({Key? key}) : super(key: key);

  @override
  _PasswordResetState createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.clear();
    super.dispose();
  }

  validate() async {
    if (_formKey.currentState!.validate()) {
      try {
        buildShowDialog(context);
        Provider.of<Authentication>(context, listen: false)
            .resetPassword(email: emailController.text)
            .then(
          (value) {
            if (value != "Success") {
              snackBar(context, value);
            } else{
              Navigator.of(context).pushReplacementNamed('SignIn');
            };
          },
        );
      } catch (e) {
        //ignored...
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: mainBackColor,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              top(context, "SignIn"),
              const Text(
                "Forget Password?\nHello There. You Forget Password?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      customTextField(
                        emailController,
                        "Email Address",
                        false,
                        context,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  validate();
                  emailController.clear();
                },
                child: buildButton("Reset Password", 350, 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
