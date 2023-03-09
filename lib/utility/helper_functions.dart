import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sonata/screens/home.dart';

void goHome(BuildContext context) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => Home()));
}

void showMsg(String text) {
  Fluttertoast.showToast(msg: text);
}
