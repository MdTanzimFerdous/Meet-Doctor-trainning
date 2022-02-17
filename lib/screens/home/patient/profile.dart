import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../../../constant/constant.dart';
import '../../../provider/profile_provider.dart';
import '../widgets/build_show_dialog.dart';
import '../widgets/profile_row.dart';
import '../widgets/show_dialog_confirmation.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? image;
  late String url;

  Future pickImage(ImageSource source, BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(
        source: source,
        imageQuality: 100,
      );

      if (image == null) {
        return;
      } else {
        //ignored...
      }

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
      if (await showDialogConfirmation(context, imageTemporary) == "Upload") {
        buildShowDialog(context);
        uploadPic(context);
      } else {
        return;
      }
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  Future uploadPic(BuildContext context) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    final ref =
        storage.FirebaseStorage.instance.ref().child("profileImage/$uid");

    final result = await ref.putFile(image!);

    url = await result.ref.getDownloadURL();

    var pro = Provider.of<ProfileProvider>(context, listen: false);
    pro.updateProfileUrl(url, uid);

    Navigator.of(context).pop();
  }

  Widget showPopUpGalleryOrCamera(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: PopupMenuButton(
        onSelected: (value) {
          if (value == 1) {
            pickImage(ImageSource.gallery, context);
          } else if (value == 2) {
            pickImage(ImageSource.camera, context);
          }
        },
        child: const Text(
          "Upload Image",
          style: TextStyle(
            color: mainColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        itemBuilder: (context) => [
          const PopupMenuItem(
            child: Text("Choose from gallery"),
            value: 1,
          ),
          const PopupMenuItem(
            child: Text("Choose from camera"),
            value: 2,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<ProfileProvider>(context);

    return Scaffold(
      backgroundColor: mainBackColor,
      appBar: AppBar(
        backgroundColor: mainBackColor,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: mainColor,
        ),
        title: const Text(
          "My Profile",
          style: TextStyle(
            color: mainColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            FontAwesomeIcons.chevronLeft,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 10.w,
          ),
          Center(
            child: Container(
              height: 150.h,
              width: 150.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(75.w),
              ),
              child: pro.profileUrl == ""
                  ? CircleAvatar(
                      backgroundColor: mainColor,
                      child: Icon(
                        Icons.person,
                        size: 60.w,
                        color: Colors.white,
                      ),
                      radius: 75.w,
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(75.w),
                      child: Image.network(
                        pro.profileUrl,
                        fit: BoxFit.cover,
                        width: 160.w,
                        height: 160.w,
                      ),
                    ),
            ),
          ),
          showPopUpGalleryOrCamera(context),
          SizedBox(
            height: 20.w,
          ),
          profileRow("Name", pro.profileName, context),
          Divider(
            thickness: 1.w,
          ),
          profileRow("Email", pro.profileEmail, context),
          Divider(
            thickness: 1.w,
          ),
        ],
      ),
    );
  }
}
