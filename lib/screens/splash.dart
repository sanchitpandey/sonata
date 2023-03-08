import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sonata/constants.dart';
import 'package:sonata/screens/login.dart';
import 'package:sonata/utility/helper_functions.dart';

import 'package:sonata/utility/helper_widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 450,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/logo-2.png"),
                    fit: BoxFit.cover),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(child: getLogo(50)),
                  addHeight(20),
                  Text(
                    'Music streaming with a social vibe',
                    style: TextStyle(
                      color: Colors.white.withOpacity(.8),
                      fontSize: 20,
                      height: 1.5,
                      shadows: const [
                        Shadow(
                          offset: Offset(.5, .5),
                          color: Color(0xFFffcc33),
                          blurRadius: 0.0,
                        ),
                        Shadow(
                          offset: Offset(0.0, 0.0),
                          color: Color(0xFF4a4a4a),
                          blurRadius: 2.0,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AuthScreen(),
                        )),
                    child: Text("Next"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
