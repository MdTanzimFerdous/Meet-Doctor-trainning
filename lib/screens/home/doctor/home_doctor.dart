import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import '../../../constant/constant.dart';
import '../../../provider/profile_provider.dart';
import '../widgets/build_bottom_navy_bar_item.dart';
import '../widgets/custom_drawer.dart';
import 'home_doctor_body.dart';

class HomeDoctor extends StatefulWidget {
  const HomeDoctor({Key? key}) : super(key: key);

  @override
  State<HomeDoctor> createState() => _HomeDoctorState();
}

class _HomeDoctorState extends State<HomeDoctor> {
  int currentIndex = 0;

  List listOfNavyBarItem = [
    {
      "page": const Padding(
        padding: EdgeInsets.fromLTRB(20, 0.0, 20.0, 0.0),
        child: HomeDoctorBody(),
      ),
    },
    {
      "page": const Center(
        child: Text(
          "Upcoming features",
        ),
      ),
    },
    {
      "page": const Center(
        child: Text(
          "Upcoming features",
        ),
      ),
    },
    {
      "page": const Center(
        child: Text(
          "Upcoming features",
        ),
      ),
      "drawer": Drawer(
        child: Column(
          children: [
            CircleAvatar(
              child: Image.asset("assets/sign_in.png"),
            ),
          ],
        ),
      ),
    },
  ];

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<ProfileProvider>(context);

    return Scaffold(
      backgroundColor: mainBackColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: mainColor),
        backgroundColor: mainBackColor,
        elevation: 0.0,
        title: Center(
          child: Text(
            "My home",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.w,
              color: mainColor,
            ),
          ),
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 15.0, 0.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed("DoctorProfile");
              },
              child: CircleAvatar(
                backgroundImage: pro.profileUrl == ""
                    ? const AssetImage("assets/user_profile.png")
                as ImageProvider
                    : NetworkImage(pro.profileUrl),
              ),
            ),
          ),
        ],
      ),
      drawer: customDrawer(context),
      body: listOfNavyBarItem[currentIndex]["page"],
      bottomNavigationBar: BottomNavyBar(
        animationDuration: const Duration(milliseconds: 200),
        backgroundColor: Colors.white,
        selectedIndex: currentIndex,
        onItemSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: <BottomNavyBarItem>[
          buildBottomNavyBarItem(FontAwesomeIcons.home, "home"),
          buildBottomNavyBarItem(FontAwesomeIcons.hospital, "Diagnosis"),
          buildBottomNavyBarItem(FontAwesomeIcons.lightbulb, "Health Tips"),
          buildBottomNavyBarItem(FontAwesomeIcons.cog, "Settings"),
        ],
      ),
    );
  }
}
