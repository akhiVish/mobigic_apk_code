import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobigic_test/screens/dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(const Duration(milliseconds: 2000), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => DashboardSccreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: const Center(
            child: Text(
          "Splash Screen",
          style: TextStyle(
              fontSize: 28, color: Colors.white, fontWeight: FontWeight.w500),
        )),
      ),
    );
  }
}
