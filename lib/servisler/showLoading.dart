import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void ShowLoadinPage(BuildContext context) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(
        'lütfen bekleyiniz..',
        style: GoogleFonts.indieFlower(fontSize: 22),
      ),
      content: Column(
        children: [
          SizedBox(height: 5),
          CupertinoActivityIndicator(radius: 13),
        ],
      ),
    ),
  );
}
