import 'dart:async';

import 'package:flutter/material.dart';
import 'package:travellinerd/core/app_constants/colors.dart';
import 'package:travellinerd/core/app_constants/strings.dart';
import 'package:travellinerd/core/global_widgets/bottom_navbar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BottomNavBar()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Icon(
              Icons.travel_explore,
              color: AppColors.whiteColor,
              size: 100,
            ),
          ),
          Text(
            AppStrings.appName,
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            AppStrings.welcomeExplore,
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: AppColors.whiteColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
