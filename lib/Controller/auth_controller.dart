import 'package:firebase/Auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Auth/Phone/otp_screen.dart';
import '../Home/home_screen.dart';

class AuthController extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  DatabaseReference ref = FirebaseDatabase.instance.ref("users");

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

  ///Forgot
  Future<void> forgotPassword(String? email, BuildContext context) async {
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
          .sendPasswordResetEmail(
        email: email!,
      )
          .then((value) {
        Navigator.of(context).pop();
        Get.to(() => const LoginScreen());
      });
    } on FirebaseException catch (e) {
      Get.snackbar(
        'Failed ${e.code}',
        '${e.message}',
        icon: const Icon(Icons.error, color: Colors.red),
        snackPosition: SnackPosition.TOP,
      );
      Navigator.of(context).pop();
    }
  }

  ///Phone Number
  Future<void> phoneNumber(
    String? phoneNumber,
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
          .verifyPhoneNumber(
              phoneNumber: phoneNumber,
              verificationCompleted: (_) {},
              verificationFailed: (e) {
                Get.snackbar(
                  'Failed ${e.code}',
                  '${e.message}',
                  icon: const Icon(Icons.error, color: Colors.red),
                  snackPosition: SnackPosition.TOP,
                );
              },
              codeSent: (String verificationId, int? token) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OTPScreen(
                              verificationID: verificationId,
                            )));
              },
              codeAutoRetrievalTimeout: (e) {
                Get.snackbar(
                  'Failed ${e.toString()}',
                  e.toString(),
                  icon: const Icon(Icons.error, color: Colors.red),
                  snackPosition: SnackPosition.TOP,
                );
              })
          .then((value) {
        Navigator.of(context).pop();
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

  ///Otp
  Future<void> oTP(
    String? otp,
    final String? verificationID,
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
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationID.toString(), smsCode: otp.toString());
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) {
        Navigator.of(context).pop();
        Get.offAll(const HomeScreen());
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

  ///Google SignUp
  Future<void> googleSignup(
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
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );
      await FirebaseAuth.instance
          .signInWithCredential(authCredential)
          .then((value) {
        Navigator.of(context).pop();
        Get.offAll(const HomeScreen());
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

  ///facebook
  Future<void> facebook(
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
      await FacebookAuth.i
          .login(permissions: ['email', 'public_profile']).then((value) {
        Navigator.of(context).pop();
        Get.offAll(const HomeScreen());
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

  ///Realtime DataBase post
  Future<void> realtimeDatabase(
    String? email,
    String? name,
    String? city,
    String? phone,
    String? address,
    String? age,
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
      final String id = DateTime.now().microsecondsSinceEpoch.toString();
      await ref.child(id).set({
        "id": id,
        "name": name!,
        "email": email!,
        "phone": phone!,
        "age": age!,
        "address": {
          "line1": address!,
          "city": city!,
        }
      }).then((value) {
        Navigator.of(context).pop();
        Get.snackbar(
          'Successfully Add',
          '',
          snackPosition: SnackPosition.TOP,
        );
        Get.offAll(const HomeScreen());
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

  ///Realtime DataBase Update
  Future<void> realtimeDatabaseUpdate(
    String? email,
    String? name,
    // String? city,
    String? phone,
    // String? address,
    String? age,
    String id,
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
      await ref.child(id).update({
        "name": name!,
        "email": email!,
        "phone": phone!,
        "age": age!,
        // "address": {
        //   "line1": address!,
        //   "city": city!,
        // }
      }).then((value) {
        Navigator.of(context).pop();
        Get.snackbar(
          'Successfully Update',
          '',
          snackPosition: SnackPosition.TOP,
        );
        Get.offAll(const HomeScreen());
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

  ///Realtime DataBase Delete
  Future<void> realtimeDatabaseDelete(
    String id,
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
      await ref.child(id).remove().then((value) {
        Navigator.of(context).pop();
        Get.snackbar(
          'Successfully delete',
          '',
          snackPosition: SnackPosition.TOP,
        );
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
}

///Login
///Signup
///logout
///current user
///forgot
///login with phone
///phone
///google sign
///facebook
///Realtime DataBase add
///Realtime DataBase edit
///Realtime DataBase Delete
///Realtime DataBase fetch
///
