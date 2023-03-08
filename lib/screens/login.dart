import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    ThemeData _theme = Theme.of(context);
    TextTheme _textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: getAppBar( _theme),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              addHeight(32),
              Text(
                _authMode == AuthMode.Login ? 'Welcome back!' : 'Welcome!',
              ),
              addHeight(16),
              Text(
                _authMode == AuthMode.Login
                    ? 'Please enter your email and password to login'
                    : 'Please enter your email and password to sign up',
              ),
              addHeight(32),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email',
                  filled: true,
                  fillColor: _theme.dialogBackgroundColor,
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
                  fillColor: _theme.dialogBackgroundColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              addHeight(32),
              _loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        _handleAuth();
                      },
                      child: Text(
                        _authMode == AuthMode.Login ? 'Login' : 'Sign Up',
                      ),
                    ),
              addHeight(16),
              TextButton(
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
                ),
              ),
            ],
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
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else if (e.code == 'email-already-in-use') {
        print('The email address is already in use by another account.');
      } else {
        print('Error: ${e.code}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}