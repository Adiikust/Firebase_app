import 'package:firebase/Controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Widget/text_button.dart';
import '../../Widget/text_form_field.dart';

class OTPScreen extends StatefulWidget {
  final String verificationID;
  const OTPScreen({Key? key, required this.verificationID}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Phone Number"),
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
                  hintText: "OTP Code",
                  controller: _otpController,
                  onChanged: (value) {}),
              const SizedBox(height: 20),
              TextBottun(
                text: "Submit",
                clickCallback: () {
                  if (_formKey.currentState!.validate()) {
                    authController.oTP(_otpController.text.toString(),
                        widget.verificationID, context);
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
