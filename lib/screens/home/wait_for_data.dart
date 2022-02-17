import 'package:flutter/material.dart';
import 'package:meet_doctor_training/screens/home/patient/home.dart';

import 'package:provider/provider.dart';

import '../../provider/profile_provider.dart';
import 'doctor/home_doctor.dart';

class WaitForData extends StatefulWidget {
  const WaitForData({Key? key}) : super(key: key);

  @override
  _WaitForDataState createState() => _WaitForDataState();
}

class _WaitForDataState extends State<WaitForData> {
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  bool isLoading = true;

  Future getData() async {
    var pro = Provider.of<ProfileProvider>(context, listen: false);
    await pro.getUserInfo();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<ProfileProvider>(context, listen: false);

    return isLoading
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.yellow,
              ),
            ),
          )
        : pro.profileStatus == "patient"
            ? Home()
            : pro.profileStatus == "doctor"
                ? const HomeDoctor()
                : const Scaffold(
                    body: Center(
                      child: Text(
                        "Something went wrong! :(",
                      ),
                    ),
                  );
  }
}
