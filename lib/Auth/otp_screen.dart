// import 'package:firebase/Auth/login_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_utils/src/get_utils/get_utils.dart';
// import '../Widget/text_button.dart';
// import '../Widget/text_form_field.dart';
//
// class OTPScreen extends StatefulWidget {
//   final String verificationID;
//   const OTPScreen({Key? key, required this.verificationID}) : super(key: key);
//
//   @override
//   State<OTPScreen> createState() => _OTPScreenState();
// }
//
// class _OTPScreenState extends State<OTPScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _otpController = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   @override
//   void dispose() {
//     _otpController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("OTP Page"),
//       ),
//       body: SafeArea(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(height: 10),
//               buildTextFormField(
//                   hintText: "OTP",
//                   controller: _otpController,
//                   validate: (value) {
//                     if (!GetUtils.isLengthGreaterOrEqual(value, 4)) {
//                       return 'please enter 4 char otp';
//                     }
//                     return null;
//                   },
//                   onChanged: (value) {}),
//               const SizedBox(height: 10),
//               TextBottun(
//                 text: "OTP",
//                 clickCallback: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const LoginScreen()));
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
