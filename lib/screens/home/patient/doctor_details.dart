import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constant/constant.dart';
import '../../../provider/profile_provider.dart';
import '../widgets/build_communication_media.dart';
import '../widgets/build_visiting_time.dart';
import '../widgets/show_dialog_appointment.dart';

class DoctorDetails extends StatefulWidget {
  const DoctorDetails({Key? key}) : super(key: key);

  @override
  _DoctorDetailsState createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  late String url, name, designation, fee, day, time, location, email, contact, size;
  bool isLoading = true;

  getUrl(String uid) async {
    DocumentSnapshot userInfo =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    url = userInfo['url'];
    name = userInfo['name'];
    designation = userInfo['designation'];
    fee = userInfo['fee'];
    day = userInfo['day'];
    time = userInfo['time'];
    location = userInfo['location'];
    email = userInfo['email'];
    contact = userInfo['contact'];

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final uidCollector = ModalRoute.of(context)!.settings.arguments;
    String uid = uidCollector.toString();
    getUrl(uid);

    var pro = Provider.of<ProfileProvider>(context);

    return Scaffold(
      body: (isLoading)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 330.w,
                      width: double.infinity,
                      child: Image.network(
                        url,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      left: 15.w,
                      top: 30.w,
                      child: GestureDetector(
                        child: Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60.w),
                            color: Colors.white,
                          ),
                          child: Icon(
                            FontAwesomeIcons.angleLeft,
                            size: 25.w,
                            color: Colors.black,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            "Home",
                          );
                        },
                      ),
                    ),
                  ],
                ),
                ListTile(
                  title: Text(
                    "Dr. " + name,
                    style: TextStyle(
                      fontSize: 20.w,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    designation,
                    style: TextStyle(
                      fontSize: 15.w,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        fee + "৳",
                        style: TextStyle(
                          fontSize: 18.w,
                          fontWeight: FontWeight.bold,
                          color: mainColor,
                        ),
                      ),
                      Text(
                        '/fee',
                        style: TextStyle(
                          fontSize: 14.w,
                          fontWeight: FontWeight.bold,
                          color: mainColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15.0.w, 0.0.w, 15.0.w, 0.0.w),
                  child: Divider(
                    thickness: 1,
                    height: 0.0,
                    color: Colors.black,
                  ),
                ),
                buildVisitingTime(day, time, location),
                buildCommunicationMedia(email, contact),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(uid)
                        .collection('patients')
                        .doc()
                        .set(
                      {
                        "name": pro.profileName,
                        "email": pro.profileEmail,
                      },
                    );

                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(uid)
                        .collection('patients')
                        .doc()
                        .set(
                      {
                        "name": pro.profileName,
                        "email": pro.profileEmail,
                      },
                    );

                    showDialogAppointment(context, uid);
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15.0.w, 0.0.w, 15.0.w, 0.0.w),
                    child: Container(
                      height: 50.w,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.w),
                        color: mainColor,
                      ),
                      child: Center(
                        child: Text(
                          "Make An Appointment",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.w,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.w,
                )
              ],
            ),
    );
  }
}
