import 'dart:async';

import 'package:firebase_flutter/Screens/home_screen.dart';
import 'package:firebase_flutter/Screens/login_screen.dart';
import 'package:firebase_flutter/Services/Utils/config.dart';
import 'package:firebase_flutter/Services/Utils/next_screen.dart';
import 'package:firebase_flutter/Services/sign_in_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //init State
  @override
  void initState() {
    final sp = context.read<SignInService>();
    super.initState();
    //timer create
    Timer(
      const Duration(seconds: 2),
      () {
        sp.isSignedIn == false
            ? nextScreen(context, const LoginScreen())
            : nextScreen(context, HomeScreen());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Image(
            image: AssetImage(Config.app_icon),
            height: 100,
            width: 100,
          ),
        ),
      ),
    );
  }
}
