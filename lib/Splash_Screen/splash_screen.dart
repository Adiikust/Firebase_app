import 'dart:async';
import 'package:firebase/Auth/login_screen.dart';
import 'package:firebase/Home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void splashDuration() {
    Timer(const Duration(seconds: 5), () {
      Get.offAll(() => FirebaseAuth.instance.currentUser != null
          ? const HomeScreen()
          : const LoginScreen());
    });
  }

  @override
  void initState() {
    splashDuration();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    splashDuration();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(
              Icons.fire_truck_outlined,
              size: 100,
              color: Colors.green,
            ),
            Text(
              "FireBase App",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.green,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
