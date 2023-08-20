// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ErrorHandle {
  void showError(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.teal,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}