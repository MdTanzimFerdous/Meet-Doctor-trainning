import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constant/constant.dart';
import '../../../provider/profile_provider.dart';
import '../widgets/build_category_item.dart';
import '../widgets/custom_search_box.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

setData(){
  FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('patient').doc().set({'p' : 'ikram'});
}


class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    List<String> categories = [
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
    ];
    List<String> categoriesImage = [
      'allergists.png',
      'cardiologists.png',
      'dermatologists.png',
      'general_surgeons.png',
      'gynecologists.png',
      'nephrologists.png',
      'neurologists.png',
      'orthopedic_surgeons.png',
      'pediatricians.png',
      'psychiatrists.png',
    ];
    var pro = Provider.of<ProfileProvider>(context);
    setData();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10.w,
        ),
        Text(
          "Hey! ${pro.profileName}",
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
        customSearchBox(context),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 20.0, 20.0, 20.0),
          child: Text(
            "Category:",
            style: TextStyle(
              fontSize: 20.w,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  "CategorizedDoctorList",
                  arguments: categories[index],
                );
              },
              child: buildCategoryItem(categories[index], categoriesImage[index]),
            ),
          ),
        ),
        SizedBox(height: 250.w),
      ],
    );
  }
}
