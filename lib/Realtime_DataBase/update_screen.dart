import 'package:firebase/Controller/auth_controller.dart';
import 'package:firebase/Widget/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Widget/text_button.dart';

class UpdateScreen extends StatefulWidget {
  String name;
  String email;
  // String city;
  String phone;
  // String address;
  String age;
  String id;

  UpdateScreen(
      {Key? key,
      required this.id,
      // required this.city,
      required this.email,
      required this.name,
      // required this.address,
      required this.age,
      required this.phone})
      : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final authController = Get.put(AuthController());
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _nameController.text = widget.name;
    _emailController.text = widget.email;
    _phoneController.text = widget.phone;
    // _addressController.text = widget.address;
    // _cityController.text = widget.city;
    _ageController.text = widget.age;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update data to Realtime Database"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              children: [
                buildTextFormField(
                  controller: _nameController,
                  hintText: "Enter Your Name",
                ),
                const SizedBox(height: 20),
                buildTextFormField(
                  controller: _emailController,
                  hintText: "Enter Your email",
                ),
                const SizedBox(height: 20),
                buildTextFormField(
                  controller: _ageController,
                  hintText: "Enter Your age",
                ),
                const SizedBox(height: 20),
                buildTextFormField(
                  controller: _cityController,
                  hintText: "Enter Your city",
                ),
                const SizedBox(height: 20),
                buildTextFormField(
                  controller: _phoneController,
                  hintText: "Enter Your Phone Number",
                ),
                const SizedBox(height: 20),
                buildTextFormField(
                  controller: _addressController,
                  hintText: "Enter Your address",
                ),
                const SizedBox(height: 20),
                TextBottun(
                  text: "Update Details",
                  clickCallback: () {
                    authController.realtimeDatabaseUpdate(
                        _emailController.text.toString(),
                        _nameController.text.toString(),
                        // _cityController.text.toString(),
                        _phoneController.text.toString(),
                        // _addressController.text.toString(),
                        _ageController.text.toString(),
                        widget.id.toString(),
                        context);
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
