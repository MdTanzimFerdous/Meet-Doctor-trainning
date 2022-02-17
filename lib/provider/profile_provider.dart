import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileProvider extends ChangeNotifier {
  String profileUrl = '', profileName = '', profileStatus = '', profileEmail = '', profileUid = '';
  String pBmdcReg = '', pContact = '', pDay = '', pDesignation = '', pFee = '', pLocation = '', pNid = '', pSpecialization = '', pTime = '';

  Future getUserInfo() async {
    profileUid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userInfo = await FirebaseFirestore.instance.collection('users').doc(profileUid).get();

    print(profileUid + " <================================");

    profileUrl = userInfo["url"];
    print(profileUrl);
    profileName = userInfo["name"];
    profileStatus = userInfo["status"];
    profileEmail = userInfo["email"];

    // For doctor purpose...
    if(profileStatus == "doctor") {
      pBmdcReg = userInfo["bmdcReg"];
      pContact = userInfo["contact"];
      pDay = userInfo["day"];
      pDesignation = userInfo["designation"];
      pFee = userInfo["fee"];
      pLocation = userInfo["location"];
      pNid = userInfo["nid"];
      pSpecialization = userInfo["specialization"];
      pTime = userInfo["time"];
    }

    notifyListeners();
  }

  Future updateProfileUrl(String url, String uid) async {
    try{
      FirebaseFirestore.instance.collection("users").doc(uid).update(
        {"url": url},
      );
      profileUrl = url;
      notifyListeners();
    } catch(e){
      //....
    }
  }
}