import 'package:firebase/Controller/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import '../Widget/text_button.dart';
import '../Widget/text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up Page"),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              buildTextFormField(
                hintText: "Email",
                controller: _emailController,
                validate: (value) {
                  if (!GetUtils.isEmail(value!)) {
                    return 'please provide a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              buildTextFormField(
                hintText: "Password",
                controller: _passwordController,
                validate: (value) {
                  if (!GetUtils.isLengthGreaterOrEqual(value, 6)) {
                    return 'please enter 6 char Password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextBottun(
                text: "Sign Up",
                // loading: loading,
                clickCallback: () {
                  if (_formKey.currentState!.validate()) {
                    authController.signUp(_emailController.text.toString(),
                        _passwordController.text.toString(), context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// setState(() {
//   loading = true;
// });
// _auth
//     .createUserWithEmailAndPassword(
//         email: _emailController.text.toString(),
//         password: _passwordController.text.toString())
//     .then((value) {
//   setState(() {
//     loading = false;
//   });
// }).onError((error, stackTrace) {
//   Utils().Toster(error.toString());
//   setState(() {
//     loading = false;
//   });
// });
