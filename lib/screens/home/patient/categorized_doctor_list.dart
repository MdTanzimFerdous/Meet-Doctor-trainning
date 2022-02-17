import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constant/constant.dart';
import '../../../provider/profile_provider.dart';

class CategorizedDoctorList extends StatefulWidget {
  const CategorizedDoctorList({Key? key}) : super(key: key);

  @override
  _CategorizedDoctorListState createState() => _CategorizedDoctorListState();
}

class _CategorizedDoctorListState extends State<CategorizedDoctorList> {
  @override
  Widget build(BuildContext context) {
    final categoryCollector = ModalRoute.of(context)!.settings.arguments;
    String category = categoryCollector.toString();

    print(category + " =============================== ");

    var pro = Provider.of<ProfileProvider>(context);
    return Scaffold(
      backgroundColor: mainBackColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: mainColor),
        backgroundColor: mainBackColor,
        elevation: 0.0,
        title: Center(
          child: Text(
            "Doctors List",
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .where("status", isEqualTo: "doctor")
            .where("designation", isEqualTo: category)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final data = snapshot.data;
          //log(data!.docs.toString() + " 11111111111111111111111");

          return ListView.builder(
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                  height: 48.h,
                  width: 350.w,
                  margin: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      //pro.searchUser(value);
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.7.sp),
                      border: InputBorder.none,
                      focusColor: Colors.amber,
                      prefixIcon: Icon(
                        Icons.search,
                        size: 24.sp,
                        color: mainColor,
                      ),
                      hintText: "Search doctors",
                      hintStyle: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
                  ),
                );
              }
              if (true) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          "DoctorDetails",
                          arguments: data!.docs[index - 1].id,
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        //height: 200.w,
                        margin: EdgeInsets.fromLTRB(25.w, 10.h, 25.w, 10.h),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 10.w),
                        decoration: BoxDecoration(
                          color: Colors.white, //Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10.w),
                          border: Border.all(
                              color: const Color(0xffE3E3E3), width: 1),
                        ),
                        child: Row(
                          children: [
                            data?.docs[index - 1]["url"] != ""
                                ? Container(
                                    /*width: 130.w,
                              height: 170.h,*/
                                    width: 70.w,
                                    height: 70.w,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(60),
                                      child: Image.network(
                                        data?.docs[index - 1]["url"],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: 70.w,
                                    height: 70.w,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(60),
                                      child: Image.asset(
                                        "assets/user_profile.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                            SizedBox(width: 15.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Dr. ${data?.docs[index - 1]["name"]}",
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                                SizedBox(height: 10.h),
                                buildRow("Blood Group :",
                                    data?.docs[index - 1]["designation"]),
                                SizedBox(height: 7.h),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox();
            },
            itemCount: data == null ? 0 : data.size + 1,
          );
        },
      ),
    );
  }

  Column buildRow(String text1, String text2) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /*Text(
          text1,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
        ),*/
        SizedBox(
          height: 20.h,
          width: 170.w,
          child: Text(
            text2,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xff6a6a6a),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
