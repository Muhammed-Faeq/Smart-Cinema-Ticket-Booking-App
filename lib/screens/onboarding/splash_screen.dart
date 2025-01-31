import 'dart:async';
import 'package:curve_navbar/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    var duration = const Duration(seconds: 3);
    Timer(duration, callback);
  }

  callback() {
    Get.offNamed(Routes.onboardingScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          "assets/logos/splash.json",
        ),
      ),
    );
  }
}
