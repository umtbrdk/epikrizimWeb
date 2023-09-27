import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void toastGetir(String message, int type) {
  type == 0
      ? Fluttertoast.showToast(
          msg: message,
          timeInSecForIosWeb: 3,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.lightGreenAccent.withOpacity(0.8),
          textColor: Colors.black,
          fontSize: 17,
        )
      : Fluttertoast.showToast(
          msg: message,
          timeInSecForIosWeb: 3,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.8),
          textColor: Colors.black,
          fontSize: 17,
        );
}
