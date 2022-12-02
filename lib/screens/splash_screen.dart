import 'dart:async';

import 'package:diamond_bag_tracking/screens/dashboard/dashboard.dart';
import 'package:diamond_bag_tracking/screens/dashboard/home/homescreen.dart';
import 'package:diamond_bag_tracking/screens/login/login.dart';
import 'package:diamond_bag_tracking/utils/constants.dart';
import 'package:diamond_bag_tracking/widgets/logo_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences? prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPreference();
  }

  initSharedPreference() async {
    prefs = await SharedPreferences.getInstance();
    Future.delayed(const Duration(seconds: 4), () async {
      var token = prefs?.getString(kToken);
      print("token: $token");
      if (token != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const DashBoard(),
          ),
          (route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image(
                image: AssetImage(iconDiamondLogo),
                fit: BoxFit.fill,
              ),
            ),
          ]),
    );
  }
}
