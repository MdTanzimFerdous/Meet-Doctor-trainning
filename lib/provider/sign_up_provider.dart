import 'package:flutter/material.dart';

class SignUpProvider with ChangeNotifier{
  bool isChecked = false;
  bool obscureText = true;

  TextEditingController passwordController = TextEditingController();

  passControllerClear() {
    passwordController.clear();
    notifyListeners();
  }

  changeCheckBox(){
    isChecked = !isChecked;
    notifyListeners();
  }

  changeObscure(){
    obscureText = !obscureText;
    notifyListeners();
  }
}