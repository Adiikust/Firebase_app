import 'package:firebase/Controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Widget/text_button.dart';
import '../Widget/text_form_field.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({Key? key}) : super(key: key);

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Page"),
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
              TextBottun(
                text: "Forgot",
                clickCallback: () {
                  if (_formKey.currentState!.validate()) {
                    authController.forgotPassword(
                        _emailController.text.toString(), context);
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
