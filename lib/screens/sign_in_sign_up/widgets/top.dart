import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

import '../../../provider/authentication.dart';

Widget top(BuildContext context, String page){
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.all(32.w),
        child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            if(page == "SignUp"){
              Provider.of<Authentication>(context, listen: false).deleteUser();
            }
            Navigator.of(context).pushReplacementNamed(page);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      const Spacer(),
      /*SizedBox(
        height: 140.h,
        width: 140.w,
        child: Image.asset("assets/top_deco.png"),
      ),*/
    ],
  );
}