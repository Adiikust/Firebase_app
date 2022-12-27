import 'package:firebase/Auth/SignUp_Screen.dart';
import 'package:firebase/Auth/forgot_screen.dart';
import 'package:firebase/Controller/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../Widget/text_button.dart';
import '../Widget/text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Login Page"),
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
                    onChanged: (value) {}),
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
                    onChanged: (value) {}),
                const SizedBox(height: 10),
                TextBottun(
                  text: "LogIn",
                  clickCallback: () {
                    if (_formKey.currentState!.validate()) {
                      authController.login(_emailController.text.toString(),
                          _passwordController.text.toString(), context);
                    }
                  },
                ),
                const SizedBox(height: 20),
                TextBottun(
                  text: "Sign Up",
                  clickCallback: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen()));
                  },
                ),
                const SizedBox(height: 20),
                TextBottun(
                  text: "Forgot",
                  clickCallback: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotScreen()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
