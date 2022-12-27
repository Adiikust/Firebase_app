import 'package:firebase/Auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Home/home_screen.dart';

class AuthController extends GetxController {
  ///LOGIN
  Future<void> login(
    String? email,
    String? password,
    BuildContext context,
  ) async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.orange,
          ),
        );
      },
      barrierDismissible: false,
    );

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email!,
        password: password!,
      )
          .then((value) {
        Navigator.of(context).pop();
        return Get.offAll(() => const HomeScreen());
      });
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Failed ${e.code}',
        '${e.message}',
        icon: const Icon(Icons.error, color: Colors.red),
        snackPosition: SnackPosition.TOP,
      );
      Navigator.of(context).pop();
    }
  }

  ///SigUp
  Future<void> signUp(
    // String? fullName,
    String? email,
    String? password,
    BuildContext context,
  ) async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      },
      barrierDismissible: false,
    );
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      )
          .then((value) {
        Navigator.of(context).pop();
        return Get.offAll(() => const LoginScreen());
        // users.add({
        //   'uid': FirebaseAuth.instance.currentUser!.uid,
        //   'name': fullName!,
        //   'email': email,
        // }).then((value) {
        //   Navigator.of(context).pop();
        //   Get.offAll(() => const LoginScreen());
        // });
      });
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      Get.snackbar(
        'Failed ${e.code}',
        '${e.message}',
        icon: const Icon(Icons.error, color: Colors.red),
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  ///LOGOUT
  Future<void> logOut(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      },
      barrierDismissible: false,
    );
    await FirebaseAuth.instance.signOut().then(
      (value) {
        Navigator.of(context).pop();
        Get.offAll(const LoginScreen());
      },
    );
  }
}

///Login
///Signup
///logout
///current user
///
