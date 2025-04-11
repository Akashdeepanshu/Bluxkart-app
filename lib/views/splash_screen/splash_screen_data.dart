import 'package:bluxkart/controllers/profileController.dart';
import 'package:bluxkart/views/auth_screen/Login_screen.dart';
import 'package:bluxkart/views/home_screen/home.dart';
import 'package:bluxkart/views/splash_screen/bgwidget_splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance; // Initialize FirebaseAuth

  void changeScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      User? user = auth.currentUser; // Get current user once
      if (user == null) {
        Get.off(() => const LoginScreen());
      } else {
        Get.lazyPut(() => ProfileController());
        Get.off(() => const Home());
      }
    });
  }

  @override
  void initState() {
    super.initState();
    changeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget_splash();
  }
}
