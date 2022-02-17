import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import '../../../constant/constant.dart';
import '../../../provider/profile_provider.dart';
import '../widgets/build_bottom_navy_bar_item.dart';
import '../widgets/custom_drawer.dart';
import 'home_body.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  List listOfNavyBarItem = [
    {
      "page": const Padding(
        padding: EdgeInsets.fromLTRB(20, 0.0, 20.0, 0.0),
        child: HomeBody(),
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
                Navigator.of(context).pushNamed("Profile");
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
          buildBottomNavyBarItem(FontAwesomeIcons.calculator, "Calculator"),
          buildBottomNavyBarItem(FontAwesomeIcons.cog, "Settings"),
        ],
      ),
    );
  }
}
