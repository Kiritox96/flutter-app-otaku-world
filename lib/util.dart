import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UtilService{
  static void showToast(String txt) {
    Fluttertoast.showToast(
      msg: txt,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white
    );

  }
  
  
}