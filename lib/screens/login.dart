import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sonata/constants.dart';
import 'package:sonata/screens/home.dart';
import 'package:sonata/utility/helper_widgets.dart';
import 'package:sonata/utility/theme_manager.dart';

enum AuthMode {
  Login,
  SignUp,
}

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  bool _loading = false;
  AuthMode _authMode = AuthMode.Login;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Scaffold(
      appBar: getAppBar(theme),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                addHeight(100),
                Text(
                  _authMode == AuthMode.Login ? 'Welcome back!' : 'Welcome!',
                  style: theme.textTheme.headline3,
                ),
                addHeight(16),
                Text(
                  _authMode == AuthMode.Login
                      ? 'Please enter your email and password to login'
                      : 'Please enter your email and password to sign up',
                  style: theme.textTheme.bodyText1,
                ),
                addHeight(32),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    filled: true,
                    fillColor: theme.dialogBackgroundColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                addHeight(16),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    filled: true,
                    fillColor: theme.dialogBackgroundColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                addHeight(32),
                _loading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: theme.primaryColor),
                        onPressed: () {
                          _handleAuth();
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            _authMode == AuthMode.Login ? 'Login' : 'Sign Up',
                            style: theme.textTheme.headline5
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                addHeight(16),
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      _authMode = _authMode == AuthMode.Login
                          ? AuthMode.SignUp
                          : AuthMode.Login;
                    });
                  },
                  child: Text(
                    _authMode == AuthMode.Login
                        ? 'New user? Sign up'
                        : 'Already have an account? Login',
                    style: theme.textTheme.headline5
                        ?.copyWith(fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleAuth() async {
    setState(() {
      _loading = true;
    });

    try {
      if (_authMode == AuthMode.Login) {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
      } else {
        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        await firestore.collection('users').doc(userCredential.user?.uid).set({
          'email': _emailController.text,
          'liked': <String>[],
        });
      }

      setState(() {
        _loading = false;
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        _loading = false;
      });

      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Wrong password provided for that user.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: 'The email address is already in use by another account.');
      } else {
        Fluttertoast.showToast(msg: 'Error: ${e.code}');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: $e');
    }
  }
}
