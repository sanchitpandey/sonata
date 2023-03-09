import 'package:flutter/material.dart';
import 'package:sonata/screens/home.dart';

void goHome(BuildContext context){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
}
