import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sonata/constants.dart';
import 'package:sonata/screens/login.dart';
import 'package:sonata/screens/splash.dart';
import 'package:sonata/utility/app_theme.dart';
import 'package:sonata/utility/theme_manager.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    const MyApp(),
  );
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            if (user == null) {
              return LoginPage();
            } else {
              return HomePage();
            }
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  @override
  void initState() {
    themeManager.addListener(themeListener);

    super.initState();
  }

  @override
  void dispose() {
    themeManager.removeListener(themeListener);
    super.dispose();
  }

  themeListener() {
    if (mounted){
      setState(() {

      });
    }
  }
}
