import 'package:flutter/material.dart';

import '../../../constant/constant.dart';

buildShowDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(
          color: mainColor,
        ),
      );
    },
  );
}
