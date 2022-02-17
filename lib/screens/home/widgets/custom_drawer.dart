import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/constant.dart';
import '../../../provider/authentication.dart';

customDrawer(BuildContext context) {
  return Drawer(
    child: Column(
      children: [
        const Spacer(),
        TextButton(
          onPressed: () {
            Provider.of<Authentication>(context, listen: false).signOut();
            Navigator.of(context).pushNamed("SignIn");
          },
          child: Row(
            children: [
              Icon(
                Icons.logout,
                size: 20.w,
                color: mainColor,
              ),
              SizedBox(
                height: 20.w,
              ),
              Text(
                "Log out",
                style: TextStyle(
                  fontSize: 20.w,
                  color: mainColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.w,
        ),
      ],
    ),
  );
}
