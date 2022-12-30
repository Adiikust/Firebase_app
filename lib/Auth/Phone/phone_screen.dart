import 'package:firebase/Controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Widget/text_button.dart';
import '../../Widget/text_form_field.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({Key? key}) : super(key: key);

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  @override
  void dispose() {
    _phoneController.dispose();
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
                  hintText: "phone number",
                  controller: _phoneController,
                  validate: (value) {
                    if (!GetUtils.isPhoneNumber(value!)) {
                      return 'please enter valid phone number';
                    }
                    return null;
                  },
                  onChanged: (value) {}),
              const SizedBox(height: 20),
              TextBottun(
                text: "Phone Number",
                clickCallback: () {
                  authController.phoneNumber(
                      _phoneController.text.toString(), context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
