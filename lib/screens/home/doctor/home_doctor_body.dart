import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constant/constant.dart';
import '../../../provider/profile_provider.dart';
import '../widgets/custom_search_box.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeDoctorBody extends StatefulWidget {
  const HomeDoctorBody({Key? key}) : super(key: key);

  @override
  _HomeDoctorBodyState createState() => _HomeDoctorBodyState();
}

class _HomeDoctorBodyState extends State<HomeDoctorBody> {
  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<ProfileProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10.w,
        ),
        Text(
          "Hey! Dr. ${pro.profileName}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.w,
            color: liteGrey,
          ),
        ),
        Text(
          "How are you today?",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.w,
            color: mainBlack,
          ),
        ),
        SizedBox(
          height: 10.w,
        ),
        //customSearchBox(context),
        Padding(
          padding: EdgeInsets.fromLTRB(0.0.w, 20.0.w, 20.0.w, 0.0.w),
          child: Text(
            "Calendar:",
            style: TextStyle(
              fontSize: 20.w,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        TableCalendar(
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2090, 3, 14),
          focusedDay: DateTime.now(),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed("PatientList");
          },
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0.0.w, 30.0.w, 20.0.w, 20.0.w),
                child: Text(
                  "Patient List",
                  style: TextStyle(
                    fontSize: 20.w,
                    fontWeight: FontWeight.bold,
                    color: mainColor,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.0.w, 30.0.w, 20.0.w, 20.0.w),
                child: const Icon(
                  FontAwesomeIcons.angleDoubleRight,
                  color: mainColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
