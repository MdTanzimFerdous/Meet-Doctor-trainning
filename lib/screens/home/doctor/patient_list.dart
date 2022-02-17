import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/constant.dart';
import '../../../provider/profile_provider.dart';

class PatientList extends StatefulWidget {
  const PatientList({Key? key}) : super(key: key);

  @override
  _PatientListState createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  int inc = 1;

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<ProfileProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your Patient List",
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(pro.profileUid)
            .collection('patients')
            //.where("status", isEqualTo: "doctor")
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
                    Card(
                      child: Row(
                        children: [
                          Text(
                            '${inc++}',
                          ),
                          Text(data?.docs[index - 1]['name']),
                          Text(data?.docs[index - 1]['email']),
                        ],
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
